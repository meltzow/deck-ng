import { Component, OnInit } from '@angular/core';
import { DefaultService, BoardService } from "@app/api/api";
import { BoardItem } from "@app/model/boardItem";
import { ToastController } from "@ionic/angular";
import { StackItem } from "@app/model";
import { BehaviorSubject } from "rxjs";
import { AuthenticationService } from "@app/services";
import { Storage } from "@ionic/storage";

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage implements OnInit {
  boards: BehaviorSubject<BoardItem[]> = new BehaviorSubject<BoardItem[]>(null);
  isLoading = true

  constructor(
    private boardService: BoardService,
    private defaultService: DefaultService,
    public toastController: ToastController,
    private autService: AuthenticationService,
    private storage: Storage,
  ) {}

  async ngOnInit() {
    await this.autService.ngOnInit()
    this.getBoards();
  }

  getBoards(): Promise<any> {
    this.isLoading = true
    return this.boardService.getBoards(true).toPromise()
      .then(value => this.boards.next(value))
      .catch(reason => {
        this.presentToastWithOptions(reason)
        return []
      }).finally(() =>
        this.isLoading = false
      )
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

  doRefresh(event) {
    this.getBoards().finally(event.target.complete())
  }

}
