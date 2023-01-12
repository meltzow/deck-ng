import { Component, OnInit, Optional } from '@angular/core';
import { AlertController, IonRouterOutlet, MenuController, Platform } from '@ionic/angular';

import { Location } from '@angular/common';
import { Router } from '@angular/router';
import { AuthenticationService, BoardService, OverviewService } from "@app/services";
import { SplashScreen } from "@capacitor/splash-screen";
import { TranslateService } from "@ngx-translate/core";
import { BehaviorSubject, Observable} from "rxjs";
import { Board } from "@app/model";
import { NotificationService } from "@app/services/notification.service";
import packagejson from '../../package.json'

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  dark = false;
  boardsSubj: BehaviorSubject<Board[]>
  appVersion: string

  nextcloudVersion: BehaviorSubject<string>
  deckVersion: BehaviorSubject<string>

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
    private overviewService: OverviewService,
    @Optional() private routerOutlet?: IonRouterOutlet
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
    this.appVersion = packagejson.version;
    await this.authService.ngOnInit();
    this.boardsSubj = this.boardService.currentBoardsSubj
    this.nextcloudVersion = this.overviewService.nextCloudVersion
    this.deckVersion = this.overviewService.deckVersion
    this.boardService.getBoards()

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
