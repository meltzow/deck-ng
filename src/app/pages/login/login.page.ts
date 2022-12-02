import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthenticationService } from '@app/services/authentication.service';
import { BoardService } from "@app/services";
import { BehaviorSubject } from "rxjs";
import { NotificationService } from "@app/services/notification.service";
import { CapacitorHttp } from '@capacitor/core';


export interface UserOptions {
  username: string;
  password: string;
  url: string
}

@Component({
  selector: 'page-login',
  templateUrl: 'login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage implements OnInit {

  login: UserOptions = { url:'', username: '', password: '' };
  submitted = false;
  isLoading = new BehaviorSubject<boolean>(false)
  showPassword = false

  constructor(
    public authenticationService: AuthenticationService,
    public boardService: BoardService,
    public router: Router,
    public notification: NotificationService
  ) {
  }

  ngOnInit(): void {
    this.authenticationService.getAccount().then(account => {
      this.login.url = account?.url
      this.login.username = account?.username
      this.login.password = account?.password
    })
  }

  onLogin(form: NgForm) {
    this.submitted = true;

    if (form.valid) {
      this.authenticationService.saveCredentials(this.login.url, this.login.username, this.login.password).then(value => {
        // Example of a GET request
        const options = {
          url: this.login.url + '/index.php/apps/deck/api/v1/boards',
          headers: {
            'Authorization': 'Basic ' + window.btoa(this.login.username + ':' + this.login.password),
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        };
        //TODO: this is a native request on devices, because of https://github.com/nextcloud/server/issues/34898
        CapacitorHttp.get(options).then(value1 => {
          this.notification.msg("successfully logged in")
        })
          .catch(reason => {
            console.error(reason)
          })
          .finally(this.isLoading.next(false));
      })
    }
  }

  onBarcode() {
    this.router.navigate(['login/barcode'])
  }

  showHidePassword() {
    this.showPassword = !this.showPassword;
  }

}
