import { Injectable } from '@angular/core';
import { Browser } from "@capacitor/browser";
import { HttpService } from "@app/services/http.service";
import { AuthenticationService } from "@app/services/authentication.service";
import { Platform } from "@ionic/angular";
import { HttpResponse } from "@angular/common/http";
import Q from "q";

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

  initialTimeoutInMs = 2000
  incrementInMs = 4000
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
      url = server.toString() + 'index.php/login/v2'
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
        // this.RepeatUntilSuccess(pollCall()myOperation, 500).then(function(value) {
        //   console.log("Wow, success: " + value);
        // })

        this.runFunctionWithRetriesAndMaxTimeout(pollCall).then(async (resp2: LoginCredentials) => {
            // timeInterval.unsubscribe()
            console.log("loginService: login true: " + resp2.loginName)
            this.cancelRetryLoop = true
            const succ: boolean = await this.authService.saveCredentials(server.toString(), resp2.loginName, resp2.appPassword, true)
            if (succ)
            resolve(succ)
        }).catch(reason => {
          console.log("loginService: login false: " + reason)
          reject(reason)
        })

        if (this.platform.is('mobile')) {
          // Browser.addListener('browserFinished', () => )
        }
      } else {
        reject('Error while connecting to ' + server)
      }
    })
  }

  // Helper to retry a function, with incrementing and a max timeout.
  private async runFunctionWithRetriesAndMaxTimeout(func: () => Promise<LoginCredentials>): Promise<unknown> {

    const overallTimeout = new Promise((resolve, reject) => {
      setTimeout( () => {
        this.cancelRetryLoop = true
        reject(new Error('Authentication hit the maximum timeout'))
      }, this.maxTimeoutInMS)
    })

    // Keep trying to execute 'func' forever.
    const operation = this.RepeatUntilSuccess(func, 2000)

    // Wait for either the retries to succeed, or the timeout to be hit.
    return  Promise.race([operation, overallTimeout])
  }

  RepeatUntilSuccess(operation, timeout): Q.Promise<any> {
    const deferred = Q.defer();
    operation().then((value) => {
      deferred.resolve(value);
    }, (reason) => {
      Q.delay(timeout).done(() => {
        if (!this.cancelRetryLoop) {
          this.RepeatUntilSuccess(operation, timeout).done((value) => {
            deferred.resolve(value);
          })
        }
      })
    })
    return deferred.promise;
  }

  cancelLogin() {
      this.cancelRetryLoop = true
  }
}

