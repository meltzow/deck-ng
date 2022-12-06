import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthenticationService } from '@app/services/authentication.service';
import { BoardService } from "@app/services";
import { BehaviorSubject, Subscription } from "rxjs";
import { NotificationService } from "@app/services/notification.service";

export interface UserOptions {
  url: string
}

@Component({
  selector: 'page-login',
  templateUrl: 'login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {

  subscription: Subscription
  login: UserOptions = { url:''};
  submitted = false;
  isLoading = new BehaviorSubject<boolean>(false)
  showPassword = false

  @ViewChild('loginForm') form: NgForm;

  constructor(
    public authenticationService: AuthenticationService,
    public boardService: BoardService,
    public router: Router,
    public notification: NotificationService
  ) {
  }

  async ngOnInit() {
    await this.authenticationService.getAccount().then(account => {
      if (account.isAuthenticated) {
        this.router.navigate(['home'])
      }
      this.login.url = account?.url
    })
  }

  ionViewWillLeave() {

  }

  async onLogin(form: NgForm) {
    this.submitted = true;

    if (form.valid) {
      this.authenticationService.isAuthObs().subscribe(success => {
        if (success) {
          this.notification.msg("successfully logged in")
          this.router.navigate(['home'])
          // this.subscription.unsubscribe()
        } else {
          this.notification.error("login not successful")
        }
      })
      await this.authenticationService.login(this.login.url)
    }
  }

  onBarcode() {
    this.router.navigate(['login/barcode'])
  }

  showHidePassword() {
    this.showPassword = !this.showPassword;
  }

}
