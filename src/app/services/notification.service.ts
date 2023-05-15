import { Injectable } from '@angular/core';
import { ToastController } from "@ionic/angular";
import { TranslateService } from "@ngx-translate/core";
import { firstValueFrom } from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  constructor(private toastController: ToastController,
              private translateService: TranslateService) { }

  private async presentToast(msg: string, type: 'success'| 'danger', header?: string) {
    const toast = await this.toastController.create({
      message: msg ,
      duration: 3000,
      position: 'bottom',
      color: type,
      header: header
    });

    await toast.present();
  }

  async msg(msg: string, header?: string) {
    const transMsg = await firstValueFrom(this.translateService.get(msg))
    this.presentToast(transMsg, 'success', header)
  }

  async error(msg: string, header?: string) {
    const transMsg = await firstValueFrom(this.translateService.get(msg))
    this.presentToast(transMsg, 'danger', header)
  }

  async systemError(msg: string, header?: string) {
    this.presentToast(msg, 'danger', header)
  }

}
