import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthenticationService } from '@app/services/authentication.service';
import { BehaviorSubject } from "rxjs";
import { NotificationService } from "@app/services/notification.service";
import { LoginService } from "@app/services/login.service";

export interface UserOptions {
  url: string
}

@Component({
  selector: 'page-login',
  templateUrl: 'login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {

  login: UserOptions = { url:''};
  submitted = false;
  isLoading = new BehaviorSubject<boolean>(false)
  showPassword = false

  @ViewChild('loginForm') form: NgForm;

  constructor(
    public authenticationService: AuthenticationService,
    private loginService: LoginService,
    public router: Router,
    public notification: NotificationService
  ) {
  }

  async ngOnInit() {
    const account = await this.authenticationService.getAccount()
    if (account) {
    if (account.isAuthenticated) {
        this.router.navigate(['home'])
      }
      this.login.url = account?.url
    }
  }

  async onLogin(form: NgForm) {
    this.submitted = true;

    if (form.valid) {
      this.isLoading.next(true)
      const succ = await this.loginService.login(new URL(this.login.url)).catch(reason => {
          if (reason.message == "SSLHandshakeException") {
             this.notification.msg("ssl shaking error")
          } else {
            this.notification.error(reason.message, "login not successful")
          }
        }).finally(() => this.isLoading.next(false))
      if (succ) {
        this.notification.msg("successfully logged in")
        this.router.navigate(['home'])
      }
    }
  }

  onBarcode() {
    this.router.navigate(['auth/barcode'])
  }

  showHidePassword() {
    this.showPassword = !this.showPassword;
  }

  cancel() {
    this.isLoading.next(false)
    this.loginService.cancelLogin()
  }
}
