import { Component, OnInit } from '@angular/core';
import { MenuController, Platform, ToastController } from '@ionic/angular';

import { Router } from '@angular/router';
import { SwUpdate } from '@angular/service-worker';
import { AuthenticationService } from "@app/services";
import { Storage } from '@ionic/storage';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  appPages = [
    {
      title: 'Home',
      url: '/home',
      icon: 'home'
    },
  ];

  loggedIn = true;
  dark = false;

  constructor(
    private menu: MenuController,
    private platform: Platform,
    private router: Router,
    private storage: Storage,
    // private swUpdate: SwUpdate,
    private toastCtrl: ToastController,
    private authService: AuthenticationService
  ) {}

  async ngOnInit() {
    // await this.storage.create();
    this.checkLoginStatus();
    this.listenForLoginEvents();

    // this.swUpdate.available.subscribe(async res => {
    //   const toast = await this.toastCtrl.create({
    //     message: 'Update available!',
    //     position: 'bottom',
    //     buttons: [
    //       {
    //         role: 'cancel',
    //         text: 'Reload'
    //       }
    //     ]
    //   });
    //
    //   await toast.present();
    //
    //   toast
    //     .onDidDismiss()
    //     .then(() => this.swUpdate.activateUpdate())
    //     .then(() => window.location.reload());
    // });
  }

  checkLoginStatus() {
    return this.authService.isLoggedIn().then(loggedIn => {
      return this.updateLoggedInStatus(loggedIn);
    });
  }

  updateLoggedInStatus(loggedIn: boolean) {
    setTimeout(() => {
      this.loggedIn = loggedIn;
    }, 300);
  }

  listenForLoginEvents() {
    window.addEventListener('user:login', () => {
      this.updateLoggedInStatus(true);
    });

    window.addEventListener('user:signup', () => {
      this.updateLoggedInStatus(true);
    });

    window.addEventListener('user:logout', () => {
      this.updateLoggedInStatus(false);
    });
  }

  logout() {

  }

  openTutorial() {

  }
}
