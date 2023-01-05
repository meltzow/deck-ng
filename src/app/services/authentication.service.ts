import { Injectable, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Storage } from '@ionic/storage';
import { Account } from '@app/model';
import { BehaviorSubject, interval, Observable, switchMap, take } from "rxjs";
import { CapacitorHttp } from "@capacitor/core";
import { Browser } from "@capacitor/browser";

export interface Login1 {
  poll: {
    token: string,
    endpoint: string
  }
  login: string
}

export interface Login2  {
  server: string,
  loginName: string,
  appPassword: string
}
@Injectable({providedIn: 'root'})
export class AuthenticationService implements OnInit {
  public static KEY_USER = 'user'
  private _isAuthSubj = new BehaviorSubject<boolean>(false);
  private _isAuthObs: Observable<boolean> = this._isAuthSubj.asObservable();

  constructor(
    private router: Router,
    public storage: Storage
  ) {

  }

  getAccount(): Promise<Account> {
    return this.storage.get(AuthenticationService.KEY_USER).then((value: Account) => {
        if (value) {
          this._isAuthSubj.next(value.isAuthenticated)
        } else {
          this._isAuthSubj.next(false)
        }
        return Promise.resolve(value)
    })
  }

  async ngOnInit() {
    await this.storage.create()
  }

  async login(url: string): Promise<boolean> {
    const options = {
      url: url + '/index.php/login/v2',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    };

    const resp1 = await CapacitorHttp.post(options)
      .catch(reason => {
        console.error(reason)
      })
      // .finally(this.isLoading.next(false));
    return new Promise((resolve, reject) => {
      if (resp1) {
        const loginData = (resp1.data as Login1)
        const options1 = {
          url: loginData.poll.endpoint,
          params: {token: loginData.poll.token},
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        };
        Browser.open({url: loginData.login})

        const obs = interval(2000)
          .pipe(
            take(60),
            switchMap(() => CapacitorHttp.post(options1))
          )

        const timeInterval = obs.subscribe(async (resp2) => {
          if (resp2.status == 200) {
            const r2 = (resp2.data as Login2)
            timeInterval.unsubscribe()
            const succ: boolean = await this.saveCredentials(url, r2.loginName, r2.appPassword, true)
            resolve(succ)
          }
        },error => {reject(error)}, () => resolve(false))
        Browser.addListener('browserFinished', () => timeInterval.unsubscribe())
      } else {
        reject('Error while connecting ' + url)
      }
    })
  }

  public async saveCredentials(url: string, username: string, password: string, isAuth = false): Promise<boolean> {
    const account1 = new Account()
    account1.username = username
    account1.password = password
    account1.authdata = window.btoa(account1.username + ':' + account1.password);
    account1.url = url
    account1.isAuthenticated = isAuth
    await this.storage.set(AuthenticationService.KEY_USER, account1).then(() => {
      this._isAuthSubj.next(isAuth)
    })
    return Promise.resolve(true)
  }

  logout(): Promise<any> {
    return this.storage.get(AuthenticationService.KEY_USER).then((value: Account) => {
      if (value) {
        value.isAuthenticated = false
        this.storage.set(AuthenticationService.KEY_USER, value)
      }
      this._isAuthSubj.next(false)

      this.router.navigate(['login'])
    })
  }

  async isAuthenticated(): Promise<boolean> {
    const value = await this.getAccount()
    if (!value) {
      return Promise.resolve(false)
    } else {
      return Promise.resolve(value.isAuthenticated)
    }
  }

  isAuthObs(): Observable<boolean> {
    return this._isAuthObs
  }

  isAuthSubj(): BehaviorSubject<boolean> {
    return this._isAuthSubj
  }
}
