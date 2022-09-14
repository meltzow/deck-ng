import { Injectable, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Storage } from '@ionic/storage';
import { Account } from '@app/model';

@Injectable({providedIn: 'root'})
export class AuthenticationService implements OnInit {
  public static KEY_USER = 'user'

  constructor(
    private router: Router,
    public storage: Storage
  ) {

  }

  getAccount(): Promise<Account> {
    return this.storage.get(AuthenticationService.KEY_USER).then(value => {
      if (value) {
        return Promise.resolve(value)
      } else {
        return Promise.reject('user not authenticated')
      }
    })
  }

  async ngOnInit() {
    await this.storage.create()
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
    this.storage.set(AuthenticationService.KEY_USER, account1).then(() => {
      this.router.navigate(['home']);
    })
  }

  logout() {
    this.storage.remove(AuthenticationService.KEY_USER).then(value => {
      this.router.navigate(['login']);
    })
  }

    isAuthenticated(): Promise<boolean> {
      return this.getAccount().then(value => value!= null)
    }

}
