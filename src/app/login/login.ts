import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

import { AuthenticationService } from '@app/services/authentication.service';


export interface UserOptions {
  username: string;
  password: string;
}

@Component({
  selector: 'page-login',
  templateUrl: 'login.html',
  styleUrls: ['./login.scss'],
})
export class LoginPage {
  login: UserOptions = { username: '', password: '' };
  submitted = false;

  constructor(
    public authenticationService: AuthenticationService,
    public router: Router
  ) { }

  onLogin(form: NgForm) {
    this.submitted = true;

    if (form.valid) {
      this.authenticationService.login(this.login.username, this.login.password);
      this.router.navigateByUrl('/home');
    }
  }

  onSignup() {
    this.router.navigateByUrl('/signup');
  }
}
