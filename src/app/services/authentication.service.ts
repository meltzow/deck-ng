import { Injectable, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Storage } from '@ionic/storage';
import { Account } from '@app/model';
import { BehaviorSubject, Observable } from "rxjs";


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

  public async saveCredentials(url: string, username: string, password: string, isAuth = false): Promise<boolean> {
    if (!username || !password) {
      return Promise.reject("no username or password must be set")
    }

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

      this.router.navigate(['auth'])
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
