import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { filter, interval, switchMap, take, timeout } from "rxjs";
import { Browser } from "@capacitor/browser";
import { HttpService } from "@app/services/http.service";
import { AuthenticationService } from "@app/services/authentication.service";
import { Platform } from "@ionic/angular";
import { HttpResponse } from "@angular/common/http";

export interface Login1 {
  poll: {
    token: string,
    endpoint: string
  }
  login: string
}

export interface Login2 {
  server: string,
  loginName: string,
  appPassword: string
}

@Injectable({providedIn: 'root'})
export class LoginService {

  constructor(
    private router: Router,
    private httpService: HttpService,
    private authService: AuthenticationService,
    private platform: Platform
  ) {

  }


  async login(server: string ): Promise<boolean> {

    let url
    if (this.platform.is("desktop")) {
      //using proxy
      url = '/index.php/login/v2'
    } else {
      url = server + '/index.php/login/v2'
    }

    const resp1 = await this.httpService.post<Login1>(url, null, {withCredentials: false})

    return new Promise((resolve, reject) => {
      if (resp1) {
        const options1 = {
          url: resp1.poll.endpoint,
          params: {token: resp1.poll.token},
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        };
        if (this.platform.is('mobile')) {
          Browser.open({url: resp1.login})
        } else {
          //remove used proxy url
          window.open(resp1.login.replace('http://localhost:8100', server), "_blank");
        }

        const obs = interval(2000)
          .pipe(
            take(60),
            switchMap(() => this.httpService.post<HttpResponse<Login2>>(options1.url, null, {params: options1.params, observe: 'response' }))
          )

        const timeInterval = obs.subscribe(async (resp2) => {
          if (resp2.status == 200) {
            const r2 = (resp2.body as Login2)
            timeInterval.unsubscribe()
            const succ: boolean = await this.authService.saveCredentials(server, r2.loginName, r2.appPassword, true)
            resolve(succ)
          }
        }, error => {
          reject(error)
        }, () => resolve(false))
        Browser.addListener('browserFinished', () => timeInterval.unsubscribe())
      } else {
        reject('Error while connecting ' + server)
      }
    })
  }

  public async accessPolling1(pollUrl: string, token: string, period: number, count: number): Promise<Login2> {
    const observablePoll = interval(period)
      .pipe(
        switchMap(() => {
          return this.httpService.post<HttpResponse<Login2>>(pollUrl, {token: token}, {observe: 'response'})
        }),
        // Filter only the successful http responses
        filter((data: any) => {
          console.log('Data:' + JSON.stringify(data));
          return data.status === 'success';
        }),
        // Emit only the first value emitted by the source
        take(1),
        timeout(30000)
      )

    return new Promise<Login2>((resolve, reject) => {
      const o = {
        next: async (resp2) => {
          if (resp2.status == 200) {
            const r2 = (resp2.body as Login2)
            timeInterval.unsubscribe()
            resolve(r2)
          }
        },
        error: (error) => {
          // reject(error)
        },
        complete: () => {
          reject(new Error('completed'))
        }
      }
      const timeInterval = observablePoll.subscribe(o)
    })

  }

  public async accessPolling(pollUrl: string, token: string, period: number, count: number): Promise<Login2> {
    const observablePoll = interval(period)
      .pipe(
        take(count),
        switchMap(() => this.httpService.post(pollUrl, {token: token}, {observe: 'response'}))
      )

    return new Promise<Login2>((resolve, reject) => {
      const o = {
        next: async (resp2) => {
          if (resp2.status == 200) {
            const r2 = (resp2.body as Login2)
            timeInterval.unsubscribe()
            resolve(r2)
          }
        },
        error: (error) => console.log(error),
        complete: () => resolve(null)
      }
      const timeInterval = observablePoll.subscribe(o)
    })

  }

}
