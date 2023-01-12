import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthenticationService } from '@app/services/authentication.service';
import { BoardService, OverviewService } from "@app/services";
import { BehaviorSubject } from "rxjs";
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
    public notification: NotificationService,
    private overviewService: OverviewService
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
      const succ = await this.authenticationService.login(this.login.url).catch(reason => {
          this.notification.error(reason.message, "login not successful")
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

}
