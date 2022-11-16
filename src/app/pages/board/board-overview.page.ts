import { Component, OnInit } from '@angular/core';
import { BoardItem } from "@app/model/boardItem";
import { ToastController } from "@ionic/angular";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  boards: BehaviorSubject<BoardItem[]> = new BehaviorSubject<BoardItem[]>(null);
  isLoading = true
  handlerMessage = '';
  roleMessage = '';

  constructor(
    private boardService: BoardService,
    public toastController: ToastController,
    private authService: AuthenticationService
  ) {}

  async ngOnInit() {
    await this.authService.ngOnInit()
    this.getBoards();
  }

  getBoards(): Promise<any> {
    this.isLoading = true
    return firstValueFrom(this.boardService.getBoards(true))
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
      message: errorMsg,
      duration: 3000,
      icon: 'information-circle',
      position: 'bottom',
      buttons: [
        {
          text: 'More Info',
          role: 'info',
          handler: () => { this.handlerMessage = 'More Info clicked'; }
        },
        {
          text: 'Dismiss',
          role: 'cancel',
          handler: () => { this.handlerMessage = 'Dismiss clicked'; }
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

  async presentToast() {
    const toast = await this.toastController.create({
      message: 'Hello World!',
      duration: 3000,
      buttons: [
        {
          text: 'More Info',
          role: 'info',
          handler: () => { this.handlerMessage = 'More Info clicked'; }
        },
        {
          text: 'Dismiss',
          role: 'cancel',
          handler: () => { this.handlerMessage = 'Dismiss clicked'; }
        }
      ]
    });

    await toast.present();

    const { role } = await toast.onDidDismiss();
    this.roleMessage = `Dismissed with role: ${role}`;
  }

}
