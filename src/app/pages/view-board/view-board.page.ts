import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Board } from "@app/model/board";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { Stack } from "@app/model/stack";
import { Card } from "@app/model/card";
import { IonModal, ToastController } from "@ionic/angular";
import { BoardService, StackService} from "@app/services";
import { OverlayEventDetail } from '@ionic/core/components';
import { CardsService } from "@app/services/cards.service";
import { NotificationService } from "@app/services/notification.service";

@Component({
  selector: 'app-view-board',
  templateUrl: './view-board.page.html',
  styleUrls: ['./view-board.page.scss'],
})
export class ViewBoardPage implements OnInit {
  public board: BehaviorSubject<Board> = new BehaviorSubject(null);
  color: any = 'rgb(255,51,0)';
  stacks: BehaviorSubject<Stack[]> = new BehaviorSubject<Stack[]>(null)
  cards: BehaviorSubject<Card[]> = new BehaviorSubject<Card[]>(null)
  private searchedCards: Card[];
  private boardId;
  @ViewChild(IonModal) modal: IonModal;
  isLoading = true;
  selectedStack: number

  constructor(
    private boardService: BoardService,
    private stackService: StackService,
    private activatedRoute: ActivatedRoute,
    public notificationService: NotificationService,
    private cardService: CardsService
  ) { }

  async ngOnInit() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('id');
    this.getBoard(this.boardId);
  }

  private getBoard(id: string) {
    this.isLoading = true
    this.boardService.getBoard(parseInt(id, 10)).then(
      board => {
        this.board.next(board)

        firstValueFrom(this.stackService.getStacks(parseInt(id, 10))).then(stacks => {
          const cards = new Array<Card>()
          stacks.forEach(stackItem => {
            stackItem.cards?.forEach(card => {
              cards.push(card)
            })
          })
          this.stacks.next(stacks)
          this.selectedStack = stacks.length ? stacks[0].id : 0
          this.cards.next(cards)
          this.searchedCards = cards
          this.isLoading = false
        })
      },
      error => {
        this.notificationService.error(error)
        console.log(error)
      })
  }

  async createCard() {
    const c = new Card()
    c.title = "foobar"
    const resp = await this.cardService.createCard(this.stacks.value[0].boardId, this.stacks.value[0].id,c)
    console.log(resp)
  }
  doRefresh(event) {
    this.board.next(null)
    this.stacks.next([])
    this.cards.next([])
    this.getBoard(this.boardId)
  }

  cancel() {
    this.modal.dismiss(null, 'cancel');
  }

  confirm() {
    this.modal.dismiss(null, 'confirm');
  }

  onWillDismiss(event: Event) {
    const ev = event as CustomEvent<OverlayEventDetail<string>>;
    if (ev.detail.role === 'confirm') {
      //this.message = `Hello, ${ev.detail.data}!`;
      console.log("filter confirmed")
    }
  }

  segmentChanged(ev: any) {
    this.selectedStack = ev.detail.value
  }

}
