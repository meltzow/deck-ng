import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient, HttpContext, HttpHeaders, HttpParams } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { interval } from "rxjs/internal/observable/interval";
import { startWith, switchMap } from "rxjs/operators";
import { Storage } from '@ionic/storage';
import { User } from '@app/model';
import { DefaultService } from "@app/api/default.service";

@Injectable({providedIn: 'root'})
export class AuthenticationService {
  public user: Observable<User>;
  private userSubject: BehaviorSubject<User>;

  constructor(
    private router: Router,
    private http: HttpClient,
    private defaultService: DefaultService,
    public storage: Storage
  ) {
    this.userSubject = new BehaviorSubject<User>(null);
    this.user = this.userSubject.asObservable();

    storage.get('user').then(value => {
      this.userSubject = new BehaviorSubject<User>(value);
      this.user = this.userSubject.asObservable();
    })
  }

  public get userValue(): User {
    return this.userSubject.value;
  }

  login(username: string, password: string) {
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

    const user = new User()
    user.username = 'admin'
    this.storage.set("user", user).then(() => {
      user.authdata = window.btoa('admin' + ':' + 'admin');
      this.userSubject.next(user);
      return window.dispatchEvent(new CustomEvent('user:login'));
    })
  }

  logout() {
    this.storage.remove('user');
    this.userSubject.next(null);
    this.router.navigate(['/login']);
  }

  isLoggedIn(): Promise<boolean> {
    return this.storage.get('user').then((value) => {
      return value === true;
    });
  }
}

interface Login1 {
  poll: {
    token: string
    endpoint: string
  }
  login: string
}

interface Login2 {
  server: string
  loginName: string
  appPassword: string
}
