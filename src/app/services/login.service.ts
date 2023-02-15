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
  cancelRetryLoop = false

  constructor(
    private httpService: HttpService,
    private authService: AuthenticationService,
    private platform: Platform
  ) {

  }

  async login(server: URL): Promise<boolean> {
    this.cancelRetryLoop = false
    let url
    if (server.hostname == "localhost" &&  this.platform.is("desktop")) {
      //using proxy
      url = '/index.php/login/v2'
    } else {
      url = server.toString() + '/index.php/login/v2'
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
          const mywindow = window.open(resp1.login.replace('http://localhost:8100', server.toString()), "_blank")
          mywindow.onunload = () => console.log('window closed')
          options1.url = options1.url.replace('http://localhost:8100', '')
        }

        const pollCall = () => this.httpService.post<LoginCredentials>(options1.url, options1.params, {withCredentials: false})
        this.runFunctionWithRetriesAndMaxTimeout(pollCall).then(async (resp2: LoginCredentials) => {
            // timeInterval.unsubscribe()
            this.cancelRetryLoop = true
            const succ: boolean = await this.authService.saveCredentials(server.toString(), resp2.loginName, resp2.appPassword, true)
            if (succ)
            resolve(succ)
        }).catch(reason => reject(reason))

        if (this.platform.is('mobile')) {
          // Browser.addListener('browserFinished', () => timeInterval.unsubscribe())
        }
      } else {
        reject('Error while connecting to ' + server)
      }
    })
  }

  // Helper delay function to wait a specific amount of time.
  private sleep(timeInMs, value?, state: 'resolve' | 'reject' = 'resolve'): Promise<unknown> {
    console.log("delay called with " + timeInMs)
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (state === "resolve") {
          return resolve(value);
        } else {
          this.cancelRetryLoop = true
          return reject(new Error(value));
        }
      }, timeInMs);
    });
  }

  // A function to just keep retrying forever.
  private async runFunctionWithRetries(func: () => Promise<LoginCredentials>, initialTimeoutInMs: number, incrementInMs: number): Promise<unknown> {
    console.log("runFunctionWithRetries called with " + initialTimeoutInMs)
    return new Promise((resolve, reject) => {
      func().then(value => resolve(value)).catch((reason) => {
        console.log("received 404 ... waiting for auth")
        this.sleep(initialTimeoutInMs).then(() => {
          if (!this.cancelRetryLoop) {
            return this.runFunctionWithRetries(func, incrementInMs, incrementInMs)
          }
        })
      })
    })
  }

  // Helper to retry a function, with incrementing and a max timeout.
  private async runFunctionWithRetriesAndMaxTimeout(func: () => Promise<LoginCredentials>): Promise<unknown> {

    const overallTimeout = this.sleep(this.maxTimeoutInMS, 'Authentication hit the maximum timeout', 'reject')

    // Keep trying to execute 'func' forever.
    const operation = this.runFunctionWithRetries(func, this.initialTimeoutInMs, this.incrementInMs);

    // Wait for either the retries to succeed, or the timeout to be hit.
    return Promise.race([operation, overallTimeout]);
  }

  cancelLogin() {
      this.cancelRetryLoop = true
  }
}

