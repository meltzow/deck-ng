import {Injectable} from '@angular/core';
import {HttpClient, HttpContext, HttpHeaders, HttpParams, HttpResponse,} from '@angular/common/http';

import {AuthenticationService} from "@app/services/authentication.service";
import {Platform} from "@ionic/angular";
import * as Cap from "@capacitor/core";
import {firstValueFrom} from "rxjs";
import {CapacitorHttpPlugin} from "@capacitor/core/types/core-plugins";
import {Account} from "@app/model";
import {NotificationService} from "@app/services/notification.service";


interface options {
  withCredentials?: boolean
}

@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(protected httpClient: HttpClient,
              private authService: AuthenticationService,
              private platform: Platform,
              private notifyService: NotificationService) {
  }

  private async getHeaders(account?: Account, isOCSRequest = false): Promise<Cap.HttpHeaders> {
    let headers: Cap.HttpHeaders = {
      'Accept': 'application/json',
      //TODO: check this header out: without it there no CORS
      // 'Content-Type': 'application/json',
      'OCS-APIRequest': 'true'
    }
    if (isOCSRequest) {
      headers = {
        'Accept': 'application/json',
        //TODO: check this header out: without it there no CORS
        // 'Content-Type': 'application/json',
        'OCS-APIRequest': 'true'
      }
    }

    if (account) {
      if (!account.isAuthenticated) {
        return Promise.resolve(null)
      }
      headers['Authorization'] = `Basic ${account.authdata}`
    }
    return headers;
  }

  public async post<T>(url: string, body?: any, options1: options = {withCredentials: true}): Promise<T> {
    let account
    if (options1.withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const headers = await this.getHeaders(account, url.startsWith('/ocs'))
      if (body) {
        headers['Content-Type'] = 'application/json'
      }
      const postoptions = {
        url: url,
        headers: headers,
        data: body
      }

      const resp1 = await Cap.CapacitorHttp.post(postoptions)
      return new Promise((resolve, reject) => {
        console.log("httpService: receive status: " + resp1.status)
        if (resp1.status <= 299 && resp1.status >= 200) {
          resolve(resp1.data)
        } else {
          reject(resp1.status)
        }
      })
    } else {
      let headers = await this.addDefaultHeaders(account, url.startsWith('/ocs'))
      headers = headers.set('Content-Type', 'application/json');
      return new Promise(resolve => {
        this.httpClient.post<T>(url,
          body,
          {headers: headers}
        ).subscribe(value => resolve(value), error => {
            this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
          }
        )
      })
    }
  }

  private isNativePlatform() {
    return this.platform.is("capacitor")
  }

  public async put<T>(url: string, body: any, options1: options = {withCredentials: true}): Promise<T> {
    let account
    if (options1.withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const headers = await this.getHeaders(account, url.startsWith('/ocs'))
      if (body) {
        headers['Content-Type'] = 'application/json'
      }
      const options = {
        url: url,
        headers: headers,
        data: body
      };
      return new Promise((resolve) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).put(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          this.notifyService.systemError(reason)
        })
      )
    } else {
      let headers = await this.addDefaultHeaders(account, url.startsWith('/ocs'))
      headers = headers.set('Content-Type', 'application/json');
      return new Promise(resolve => {
        this.httpClient.put<T>(url,
          body,
          {headers: headers}
        ).subscribe(value => resolve(value), error => {
            this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
          }
        )
      })
    }

  }

  public async get<T>(url: string, options1: options = {withCredentials: true}): Promise<T> {
    let account
    if (options1.withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const options = {
        url: url,
        headers: await this.getHeaders(account, url.startsWith('/ocs')),
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).get(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          console.error(reason)
          reject(reason)
        })
      )
    } else {
      const headers = await this.addDefaultHeaders(account, url.startsWith('/ocs'))
      return new Promise((resolve, reject) =>
        this.httpClient.get<T>(url, {
          observe: 'body',
          responseType: 'json',
          headers: headers
        }).subscribe(value => resolve(value), error => {
            this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
          }
        ))
    }
  }

  public async delete<T>(url: string, options1: options = {withCredentials: true}): Promise<T> {
    let account
    if (options1.withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const options = {
        url: url,
        headers: await this.getHeaders(account, url.startsWith('/ocs')),
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).delete(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          console.error(reason)
          reject(reason)
        })
      )
    } else {
      const headers = await this.addDefaultHeaders(account, url.startsWith('/ocs'))
      return new Promise(resolve => {
        this.httpClient.delete<T>(url, {
          observe: 'body',
          responseType: 'json',
          headers: headers
        }).subscribe(value => resolve(value), error => {
            this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
          }
        )
      })
    }
  }

  private async addDefaultHeaders(account?: Account, isOCSRequest = false): Promise<HttpHeaders> {
    let localVarHeaders = new HttpHeaders();

    if (account) {
      localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + account.authdata);
    }

    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    //TODO: check this header out: without it there no CORS
    // localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    if (isOCSRequest) {
      localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    }
    return localVarHeaders
  }

}
