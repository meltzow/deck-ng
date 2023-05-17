import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Board } from "@app/model/board";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { Stack } from "@app/model/stack";
import { Card } from "@app/model/card";
import {
  AlertController,
  IonModal,
  ItemReorderEventDetail
} from "@ionic/angular";
import { BoardService, StackService } from "@app/services";
import { OverlayEventDetail } from '@ionic/core/components';
import { CardsService } from "@app/services/cards.service";
import { NotificationService } from "@app/services/notification.service";
import { TranslateService } from "@ngx-translate/core";

@Component({
  selector: 'app-view-board',
  templateUrl: './board-details.page.html',
  styleUrls: ['./board-details.page.scss'],
})
export class BoardDetailsPage implements OnInit {
  public board: BehaviorSubject<Board> = new BehaviorSubject(null);
  stacks: BehaviorSubject<Stack[]> = new BehaviorSubject<Stack[]>(null)
  private searchedCards: Card[];
  private boardId;
  @ViewChild(IonModal) modal: IonModal
  isLoading = false;
  selectedIdx: number
  selectedStack: BehaviorSubject<Stack> = new BehaviorSubject<Stack>(null)

  constructor(
    private boardService: BoardService,
    private stackService: StackService,
    private activatedRoute: ActivatedRoute,
    public notificationService: NotificationService,
    private alertController: AlertController,
    private cardService: CardsService,
    private translateService: TranslateService
  ) { }

  async ngOnInit() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('id');
  }

  private async getBoard(id: string) {
    this.isLoading = true
    const board = await this.boardService.getBoard(parseInt(id, 10))
    this.board.next(board)
    const stacks = await this.stackService.getStacks(parseInt(id, 10)).finally(() => this.isLoading = false)
    stacks.forEach(value => value.cards?.sort((a, b) => a.order - b.order))
    this.stacks.next(stacks)
    this.selectedIdx =  this.selectedIdx? this.selectedIdx : 0
    this.selectedStack.next(stacks.length ? stacks[this.selectedIdx] : null )

  }

  async createStack() {

  }

  async createCard() {
    const header = await firstValueFrom(this.translateService.get('create card'))
    const description = await firstValueFrom(this.translateService.get('title_placeholder'))
    await this.showModal(header, description, (data) => {
      this.confirmHandler(data)
    } )
  }

  async showModal(header: string, description: string, handler: (value: any) => (any | Promise<any>) ) {
    const cancel = await firstValueFrom(this.translateService.get('cancel'))
      const alert = await this.alertController.create({
        header: header,
        buttons: [{
          text: cancel,
          role: 'cancel'
        },
          {
            text: 'OK',
            role: 'confirm',
            handler: handler,
          },],
        inputs: [
          {
            name: 'title',
            placeholder: description,
          },
        ],
      });

      await alert.present();
  }

  confirmHandler(data: { title: string }) {
    const c = new Card()
    c.title = data.title
    c.stackId = this.selectedStack.value.id
    c.order = this.selectedStack.value.cards ? this.selectedStack.value.cards[this.selectedStack.value.cards.length -1].order + 1 : 0
    this.isLoading = true
    this.cardService.createCard(this.boardId, this.selectedStack.value.id, c)
      .then(value => {
        this.notificationService.msg('card successfully created')
        this.getBoard(this.boardId)
      })
      .catch(reason => this.notificationService.error(reason))
      .finally(() => this.isLoading = false )
  }

  doRefresh(event) {
    this.refreshBoard();
    event.target.complete();
  }

  private refreshBoard() {
    this.board.next(null)
    this.stacks.next([])
    this.getBoard(this.boardId)
  }

  cancel() {
    this.modal.dismiss(null, 'cancel');
  }

  confirm() {
    this.modal.dismiss(null, 'confirm');
  }

  async ionViewWillEnter() {
    await this.getBoard(this.boardId);
  }

  onWillDismiss(event: Event) {
    const ev = event as CustomEvent<OverlayEventDetail<string>>;
    if (ev.detail.role === 'confirm') {
      //this.message = `Hello, ${ev.detail.data}!`;
      console.log("filter confirmed")
    }
  }

  segmentChanged(ev: any) {
    const segmentIdx = ev.detail.value
    const stack = this.stacks.value[segmentIdx]
    if (stack) {
      this.selectedIdx = ev.detail.value
      this.selectedStack.next(stack)
    }
  }

  stackIsSelected(): boolean {
    return this.selectedStack.value?.id > -1
  }

  handleReorder(ev: CustomEvent<ItemReorderEventDetail>) {
    this.arraymove(this.selectedStack.value.cards, ev.detail.from, ev.detail.to)
    const cardAbove = this.selectedStack.value.cards[ev.detail.to -1]
    let newIndex = 0
    if (cardAbove) {
      newIndex = cardAbove.order + 1
    }
    const droppedCard = this.selectedStack.value.cards[ev.detail.to]
    droppedCard.order = newIndex
    this.updateCard(droppedCard)

    // Finish the reorder and position the item in the DOM based on
    // where the gesture ended. This method can also be called directly
    // by the reorder group
    ev.detail.complete();
  }

  moveToRight(card: Card): void {
    const stackNeighbour = this.findNeighbour(card.stackId, 'right')
    if (stackNeighbour) {
      card.stackId = stackNeighbour.id
      this.updateCard(card)
    }
  }

  moveToLeft(card: Card): void {
    const stackNeighbour = this.findNeighbour(card.stackId, 'left')
    if (stackNeighbour) {
      card.stackId = stackNeighbour.id
      this.updateCard(card)
    }
  }

  hasLeftNeighbour(): boolean {
    return !!this.findNeighbour(this.selectedStack.value.id, 'left');
  }

  findNeighbour(stackId: number, directions: 'left' | 'right'): Stack | null {
    const idx = this.stacks.value.findIndex(value => value.id == stackId)
    const newIdx = directions == "left" ? idx - 1 : idx + 1
    return this.stacks.value[newIdx];
  }

  hasRightNeighbour(): boolean {
    return !!this.findNeighbour(this.selectedStack.value.id, 'right');
  }

  private updateCard(card: Card) {
    this.isLoading = true
    this.cardService.updateCard(this.boardId, card.stackId, card.id, card)
      .then(value => {
        this.notificationService.msg('card successfully updated')
      })
      .catch(reason => this.notificationService.error(reason))
      .finally(() => this.refreshBoard())
  }

  private arraymove(arr, fromIndex, toIndex) {
    const element = arr[fromIndex];
    arr.splice(fromIndex, 1);
    arr.splice(toIndex, 0, element);
  }
}
