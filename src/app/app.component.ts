import { Component, OnInit, Optional } from '@angular/core';
import { AlertController, IonRouterOutlet, MenuController, Platform, ToastController } from '@ionic/angular';

import { Location } from '@angular/common';
import { Router } from '@angular/router';
import { SwUpdate } from '@angular/service-worker';
import { AuthenticationService, BoardService } from "@app/services";
import { SplashScreen } from "@capacitor/splash-screen";
import { TranslateService } from "@ngx-translate/core";
import { BehaviorSubject, from, Observable, of, share } from "rxjs";
import { StatusBar, Style } from '@capacitor/status-bar';
import { BoardItem } from "@app/model";
import { NotificationService } from "@app/services/notification.service";

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  dark = false;
  boardsSubj = new BehaviorSubject<BoardItem[]>([])

  constructor(
    private menu: MenuController,
    private platform: Platform,
    private router: Router,
    private navigation: NotificationService,
    private authService: AuthenticationService,
    private translate: TranslateService,
    private location: Location,
    public alertCtrl: AlertController,
    private boardService: BoardService,
    @Optional() private routerOutlet?: IonRouterOutlet,
  ) {
    translate.addLangs(['de', 'en']);
    translate.setDefaultLang('en');
    translate.use(translate.getBrowserLang())
    this.initializeApp();
  }

  initializeApp() {
    this.platform.ready().then(() => {
      // this.statusBar.styleDefault();
      // Hide the splash (you should do this on app launch)
      SplashScreen.hide();
    });


    this.platform.backButton.subscribeWithPriority(-1, () => {
      if (!this.routerOutlet.canGoBack()) {
        this.confirmExitApp();
      } else {
        this.location.back();
      }
    });

  }

  async confirmExitApp() {
    const alert = await this.alertCtrl.create({
      header: 'Confirmation Exit',
      message: 'Are you sure you want to exit ?',
      backdropDismiss: false,
      cssClass: 'confirm-exit-alert',
      buttons: [{
        text: 'Stay',
        role: 'cancel',
        handler: () => {
          console.log('Application exit handler');
        }
      }, {
        text: 'Exit app',
        handler: () => {
          navigator['app'].exitApp();
        }
      }]
    });

    await alert.present();
  }

  async ngOnInit() {
    await this.authService.ngOnInit();
    this.boardService.getBoards().subscribe(value => this.boardsSubj.next(value))

    setTimeout(() => {
      SplashScreen.hide();
    }, 1000);
  }

  isAuthenticated(): Observable<boolean> {
    return this.authService.isAuthObs()
  }

  logout() {
    this.authService.logout()
    this.navigation.msg("successfully logged out")
  }


}
