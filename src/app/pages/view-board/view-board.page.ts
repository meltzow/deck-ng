import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BoardItem } from "@app/model/boardItem";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { StackItem } from "@app/model/stackItem";
import { Card } from "@app/model/card";
import { IonModal, ToastController } from "@ionic/angular";
import { BoardService, StackService} from "@app/services";
import { OverlayEventDetail } from '@ionic/core/components';

@Component({
  selector: 'app-view-board',
  templateUrl: './view-board.page.html',
  styleUrls: ['./view-board.page.scss'],
})
export class ViewBoardPage implements OnInit {
  public board: BehaviorSubject<BoardItem> = new BehaviorSubject(null);
  color: any = 'rgb(255,51,0)';
  stacks: BehaviorSubject<StackItem[]> = new BehaviorSubject<StackItem[]>(null)
  cards: BehaviorSubject<Card[]> = new BehaviorSubject<Card[]>(null)
  private searchedCards: Card[];
  private boardId;
  @ViewChild(IonModal) modal: IonModal;
  isLoading = true;

  constructor(
    private boardService: BoardService,
    private stackService: StackService,
    private activatedRoute: ActivatedRoute,
    public toastController: ToastController
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
          this.cards.next(cards)
          this.searchedCards = cards
          this.isLoading = false
        })
      },
      error => {
        this.presentToastWithOptions(error)
        console.log(error)
      })
  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }

  doRefresh(event) {
    this.board.next(null)
    this.stacks.next([])
    this.cards.next([])
    this.getBoard(this.boardId)
  }

  async presentToastWithOptions(errorMsg: string) {
    const toast = await this.toastController.create({
      header: 'Toast header',
      message: 'Click to Close',
      icon: 'information-circle',
      position: 'top',
      buttons: [
        // {
        //   side: 'start',
        //   icon: 'star',
        //   text: 'Favorite',
        //   handler: () => {
        //     console.log('Favorite clicked');
        //   }
        // },
        {
          text: errorMsg,
          role: 'cancel',
          handler: () => {
            console.log('Cancel clicked');
          }
        }
      ]
    });
    await toast.present();

    const { role } = await toast.onDidDismiss();
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
}
