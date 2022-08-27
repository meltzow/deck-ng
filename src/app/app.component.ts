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

  dark = false;

  constructor(
    private menu: MenuController,
    private platform: Platform,
    private router: Router,
    private storage: Storage,
    private toastCtrl: ToastController,
    private authService: AuthenticationService
  ) {}

  async ngOnInit() {
    await this.authService.ngOnInit();
  }

  get loggedIn() {
    return this.authService.isAuthenticated()
  }

  logout() {
    this.authService.logout()
  }

  openTutorial() {

  }
}
