import { Injectable } from '@angular/core';
import { AlertController, ToastController } from "@ionic/angular";

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  constructor(private toastController: ToastController,
              private alertController: AlertController) { }

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

  msg(msg: string, header?: string) {
    this.presentToast(msg, 'success', header)
  }

  error(msg: string, header?: string) {
    this.presentToast(msg, 'danger', header)
  }


}
