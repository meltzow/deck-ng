import { Injectable } from '@angular/core';
import { Browser } from "@capacitor/browser";
import { HttpService } from "@app/services/http.service";
import { AuthenticationService } from "@app/services/authentication.service";
import { Platform } from "@ionic/angular";
import { HttpResponse } from "@angular/common/http";

export interface LoginPollInfo {
  poll: {
    token: string,
    endpoint: string
  }
  login: string
}

export interface LoginCredentials {
  server: string,
  loginName: string,
  appPassword: string
}

@Injectable({providedIn: 'root'})
export class LoginService {

  initialTimeoutInMs = 1000
  incrementInMs = 2000
  maxTimeoutInMS = 120000

  constructor(
    private httpService: HttpService,
    private authService: AuthenticationService,
    private platform: Platform
  ) {

  }

  async login(server: string): Promise<boolean> {

    let url
    if (this.platform.is("desktop")) {
      //using proxy
      url = '/index.php/login/v2'
    } else {
      url = server + '/index.php/login/v2'
    }

    const resp1 = await this.httpService.post<LoginPollInfo>(url, null, {withCredentials: false})

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
          const mywindow = window.open(resp1.login.replace('http://localhost:8100', server), "_blank")
          mywindow.onunload = () => console.log('window closed')
          options1.url = options1.url.replace('http://localhost:8100', '')
        }

        const pollCall = () => this.httpService.post<LoginCredentials>(options1.url, options1.params, {withCredentials: false})
        this.runFunctionWithRetriesAndMaxTimeout(pollCall).then(async (resp2: LoginCredentials) => {
            // timeInterval.unsubscribe()
            const succ: boolean = await this.authService.saveCredentials(server, resp2.loginName, resp2.appPassword, true)
            if (succ)
            resolve(succ)
        })

        if (this.platform.is('mobile')) {
          // Browser.addListener('browserFinished', () => timeInterval.unsubscribe())
        }
      } else {
        reject('Error while connecting to ' + server)
      }
    })
  }

  private timeout(ms) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        reject("timeout");
      }, ms);
    });
  }

  // Helper delay function to wait a specific amount of time.
  private async delay(timeInMs: number): Promise<unknown> {
    console.log("delay called with " + timeInMs)
    return new Promise((resolve, reject) => setTimeout(resolve, timeInMs))
  }

  // A function to just keep retrying forever.
  private async runFunctionWithRetries(func: () => Promise<LoginCredentials>, initialTimeoutInMs: number, incrementInMs: number): Promise<unknown> {
    console.log("runFunctionWithRetries called with " + initialTimeoutInMs)
    return func().catch((reason) => {
      console.log("received 404 ... waiting for auth")
      this.delay(initialTimeoutInMs).then(() => {
        this.runFunctionWithRetries(func, incrementInMs, incrementInMs)
      })
    })
  }

  // Helper to retry a function, with incrementing and a max timeout.
  private async runFunctionWithRetriesAndMaxTimeout(func: () => Promise<LoginCredentials>): Promise<unknown> {

    const overallTimeout = this.timeout(this.maxTimeoutInMS).catch(() => {
      return Promise.reject('Authentication hit the maximum timeout')
    });

    // Keep trying to execute 'func' forever.
    const operation = this.runFunctionWithRetries(func, this.initialTimeoutInMs, this.incrementInMs);

    // Wait for either the retries to succeed, or the timeout to be hit.
    return Promise.race([operation, overallTimeout]);
  }

}

