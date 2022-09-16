import { Component, OnInit } from '@angular/core';
import { MenuController, Platform, ToastController } from '@ionic/angular';

import { Router } from '@angular/router';
import { SwUpdate } from '@angular/service-worker';
import { AuthenticationService } from "@app/services";
import { SplashScreen } from "@capacitor/splash-screen";
import { TranslateService } from "@ngx-translate/core";
import { from, Observable, of, share } from "rxjs";

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  dark = false;
  courseObs: Observable<boolean>;

  constructor(
    private menu: MenuController,
    private platform: Platform,
    private router: Router,
    private toastCtrl: ToastController,
    private authService: AuthenticationService,
    private translate: TranslateService
  ) {
    translate.addLangs(['de', 'en']);
    translate.setDefaultLang('en');
    translate.use(translate.getBrowserLang())
  }

  async ngOnInit() {
    await this.authService.ngOnInit();
    setTimeout(() => {
      SplashScreen.hide();
    }, 1000);
    this.courseObs = from(this.authService.isAuthenticated())
  }

  isAuthenticated(): Observable<boolean> {
    return this.courseObs
  }

  logout() {
    this.authService.logout()
  }

  openTutorial() {

  }
}
