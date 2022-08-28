import { Injectable, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient, HttpContext, HttpHeaders, HttpParams } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { interval } from "rxjs/internal/observable/interval";
import { startWith, switchMap } from "rxjs/operators";
import { Storage } from '@ionic/storage';
import { Account } from '@app/model';
import { DefaultService } from "@app/api/default.service";
import { Platform } from "@ionic/angular";

@Injectable({providedIn: 'root'})
export class AuthenticationService implements OnInit {
  public account: BehaviorSubject<Account> = new BehaviorSubject<any>({});
  authState = new BehaviorSubject(false);

  constructor(
    private router: Router,
    private http: HttpClient,
    private platform: Platform,
    public storage: Storage
  ) {
    this.platform.ready().then(() => {
      this.ifLoggedIn();
    });
  }

  ifLoggedIn() {
    this.storage.get('USER_INFO').then((response) => {
      if (response) {
        this.authState.next(true);
      }
    });
  }

  async ngOnInit() {
    await this.storage.create()
    await this.storage.get('user').then(value => {
      if (value)
        this.account = new BehaviorSubject<Account>(value);
    })
  }

  login(url: string, username: string, password: string) {
    // see https://docs.nextcloud.com/server/latest/developer_manual/client_apis/LoginFlow/index.html#login-flow-v2
    // curl -X POST https://cloud.example.com/index.php/login/v2
    // let polling
    // this.defaultService.loginV2Post()
    //   //
    //   // return this.http.post<Login1>(`${environment.nextcloudApiUrl}/index.php/login/v2`, {}, {
    //   //   context: new HttpContext(),
    //   //   params: new HttpParams({encoder:  new CustomHttpParameterCodec()}),
    //   //   responseType: <any>'json',
    //   //   withCredentials: false,
    //   //   headers: new HttpHeaders(),
    //   //   observe: 'body',
    //   //   reportProgress: false
    //   // })
    //   .subscribe(loginValue1 => {
    //     console.warn("please do a manual login at: ", loginValue1.login)
    //     const formData = new FormData()
    //     formData.append('token', loginValue1.poll.token)
    //     polling = interval(2000).pipe(
    //       startWith(0),
    //       switchMap(() => this.http.post<Login2>(loginValue1.poll.endpoint, formData))
    //     ).subscribe(loginValue2 => {
    //       console.log("successfull login: ", loginValue2.loginName, loginValue2.appPassword);
    //       polling.unsubscribe();
    //     })
    //   })

    const account1 = new Account()
    account1.username = username
    account1.password = password
    account1.authdata = window.btoa(account1.username + ':' + account1.password);
    account1.url = url
    this.storage.set("user", account1).then(() => {
      this.account.next(account1);
      this.authState.next(true);
      this.router.navigate(['home']);
    })
  }

  logout() {
    this.storage.remove("user").then(value => {
      this.account.next(null);
      this.authState.next(false)
      this.router.navigate(['/login']);
    })
  }

    isAuthenticated() {
      return this.authState.value;
    }

}
