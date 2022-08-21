import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BoardItem } from "@app/model/boardItem";
import { BehaviorSubject } from "rxjs";
import { StackItem } from "@app/model/stackItem";
import { Card } from "@app/model/card";
import { ToastController } from "@ionic/angular";
import { StackService, BoardService } from "@app/api/api";

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
  name = 'dfdd';
  private boardId;

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

  private getBoard(id: string): Promise<void | BoardItem> {
    return this.boardService.getBoard(parseInt(id, 10)).toPromise().then(
      board => {
        this.board.next(board)
        this.stackService.getStacks(parseInt(id, 10)).toPromise().then(stacks => {
          const cards = new Array<Card>()
          stacks.forEach(stackItem => {
            stackItem.cards?.forEach(card => {
              cards.push(card)
            })
          })
          this.stacks.next(stacks)
          this.cards.next(cards)
        })
      },
      error => {
        this.presentToastWithOptions(error)
        console.log(error)
      },
    )
  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }

  doRefresh(event) {
    this.getBoard(this.boardId)
    console.log('Begin async operation');

    setTimeout(() => {
      console.log('Async operation has ended');
      event.target.complete();
    }, 2000);
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
    console.log('onDidDismiss resolved with role', role);
  }

}
