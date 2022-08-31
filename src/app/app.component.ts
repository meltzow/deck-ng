import { Component, OnInit } from '@angular/core';
import { MenuController, Platform, ToastController } from '@ionic/angular';

import { Router } from '@angular/router';
import { SwUpdate } from '@angular/service-worker';
import { AuthenticationService } from "@app/services";
import { Storage } from '@ionic/storage';
import { SplashScreen } from "@capacitor/splash-screen";
import { TranslateService } from "@ngx-translate/core";

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  dark = false;

  constructor(
    private menu: MenuController,
    private platform: Platform,
    private router: Router,
    private storage: Storage,
    private toastCtrl: ToastController,
    private authService: AuthenticationService,
    private translate: TranslateService
  ) { }

  async ngOnInit() {
    await this.authService.ngOnInit();
    setTimeout(() => {
      SplashScreen.hide();
    }, 2000);
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
