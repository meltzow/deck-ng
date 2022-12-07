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
      const succ = await this.authenticationService.login(this.login.url).catch(reason => {
        this.notification.error(reason.message, "login not successful")
      })
      if (succ) {
        this.notification.msg("successfully logged in")
        this.router.navigate(['home'])
      } else {
        this.notification.error("login not successful")
      }
    }
  }

  onBarcode() {
    this.router.navigate(['login/barcode'])
  }

  showHidePassword() {
    this.showPassword = !this.showPassword;
  }

}
