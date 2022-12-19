import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Board } from "@app/model/board";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { Stack } from "@app/model/stack";
import { Card } from "@app/model/card";
import { AlertController, IonModal, ToastController } from "@ionic/angular";
import { BoardService, StackService} from "@app/services";
import { OverlayEventDetail } from '@ionic/core/components';
import { CardsService } from "@app/services/cards.service";
import { NotificationService } from "@app/services/notification.service";

@Component({
  selector: 'app-view-board',
  templateUrl: './board-details.page.html',
  styleUrls: ['./board-details.page.scss'],
})
export class BoardDetailsPage implements OnInit {
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
    private alertController: AlertController,
    private cardService: CardsService
  ) { }

  async ngOnInit() {

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
          this.selectedStack = stacks.length ? (this.selectedStack? this.selectedStack : stacks[0].id ): -1
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

  async promptTitle() {
      const alert = await this.alertController.create({
        header: 'Please enter the title',
        buttons: [{
          text: 'Cancel',
          role: 'cancel'
        },
          {
            text: 'OK',
            role: 'confirm',
            handler: (data) => {
              this.confirmHandler(data);
            },
          },],
        inputs: [
          {
            name: 'title',
            placeholder: 'what needs to be done',
          },
        ],
      });

      await alert.present();
  }

  confirmHandler(data: { title: string }) {
    const c = new Card()
    c.title = data.title
    c.stackId = this.selectedStack
    this.isLoading = true
    this.cardService.createCard(this.boardId, this.selectedStack, c)
      .then(value => {
        this.notificationService.msg('card created')
        this.getBoard(this.boardId)
      })
      .catch(reason => this.notificationService.error(reason))
      .finally(() => this.isLoading = false )
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

  async ionViewWillEnter() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('id');
    this.getBoard(this.boardId);
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

  stackIsSelected(): boolean {
    return this.selectedStack > -1
  }
}
