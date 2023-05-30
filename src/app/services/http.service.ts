import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

import {AuthenticationService} from "@app/services/authentication.service";
import {Platform} from "@ionic/angular";
import * as Cap from "@capacitor/core";
import {CapacitorHttpPlugin} from "@capacitor/core/types/core-plugins";
import {Account} from "@app/model";
import {NotificationService} from "@app/services/notification.service";


@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(protected httpClient: HttpClient,
              private authService: AuthenticationService,
              private platform: Platform,
              private notifyService: NotificationService) {
  }


  public async post<T>(url: string, body?: any, withCredentials =  true, displayError = true): Promise<T> {
    let account
    if (withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const headers = await this.getHeadersNative(account, url, body)
      const postoptions = {
        url: url,
        headers: headers,
        data: body
      }

      return new Promise((resolve, reject) => {
      Cap.CapacitorHttp.post(postoptions)
        .then(resp => {
          console.log("httpService: receive status: " + resp.status)
          if (resp.status <= 299 && resp.status >= 200) {
            resolve(resp.data as T)
          } else {
            if (displayError) {
              this.notifyService.systemError((resp as any).message)
            }
            reject(resp.status)
          }
        }).catch(reason => {
          if (displayError) {
            this.notifyService.systemError(reason)
          }
          reject(reason)
        })
      })
    } else {
      const headers = await this.getHeaders(account, url, body)
      return new Promise((resolve, reject) => {
        this.httpClient.post<T>(url,
          body,
          {headers: headers}
        ).subscribe(value => resolve(value), error => {
            if (displayError) {
              this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
            }
            reject(error)
          }
        )
      })
    }
  }

  public isNativePlatform() {
    return this.platform.is("capacitor")
  }

  public async put<T>(url: string, body: any, withCredentials = true, displayError = true): Promise<T> {
    let account
    if (withCredentials) {
      account = await this.authService.getAccount()
      if (!url.startsWith("/"))
        throw Error("when using credentials the url must be start with '/'")
      if (this.isNativePlatform()) {
        url = account.url + url
      }
    }

    if (this.isNativePlatform()) {
      const headers = await this.getHeadersNative(account, url, body)
      const options = {
        url: url,
        headers: headers,
        data: body
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).put(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
            if (displayError) {
              this.notifyService.systemError(reason)
            }
            reject(reason)
        })
      )
    } else {
      let headers = await this.getHeaders(account, url)
      headers = headers.set('Content-Type', 'application/json');
      return new Promise((resolve, reject) => {
        this.httpClient.put<T>(url,
          body,
          {headers: headers}
        ).subscribe(value => resolve(value), error => {
            if (displayError) {
              this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
            }
            reject(error)
          }
        )
      })
    }

  }

  public async get<T>(url: string, withCredentials = true, displayError = true): Promise<T> {
    let account
    if (withCredentials) {
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
        headers: await this.getHeadersNative(account, url),
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).get(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          if (displayError) {
            this.notifyService.systemError(reason)
          }
          reject(reason)
        })
      )
    } else {
      const headers = await this.getHeaders(account, url)
      return new Promise((resolve, reject) =>
        this.httpClient.get<T>(url, {
          observe: 'body',
          responseType: 'json',
          headers: headers
        }).subscribe(value => resolve(value), error => {
            if (displayError) {
              this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
            }
            reject(error)
          }
        ))
    }
  }

  public async delete<T>(url: string, withCredentials = true, displayError = true): Promise<T> {
    let account
    if (withCredentials) {
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
        headers: await this.getHeadersNative(account, url),
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).delete(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          if (displayError) {
            this.notifyService.systemError(reason)
          }
          reject(reason)
        })
      )
    } else {
      const headers = await this.getHeaders(account, url)
      return new Promise((resolve, reject) => {
        this.httpClient.delete<T>(url, {
          observe: 'body',
          responseType: 'json',
          headers: headers
        }).subscribe(value => resolve(value), error => {
          if (displayError) {
            this.notifyService.systemError(error.message, error.status + ":" + error.statusText)
          }
          reject(error)
          }
        )
      })
    }
  }

  private async getHeaders(account: Account, url: string, body?: any): Promise<HttpHeaders> {
    let localVarHeaders = new HttpHeaders();

    if (account) {
      localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + account.authdata);
    }

    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    //TODO: check this header out: without it there no CORS
    // localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    if (url.startsWith('/ocs') || url.startsWith('/index.php/login/v2')) {
      localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    }
    if (body) {
      localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    }
    return localVarHeaders
  }

  private async getHeadersNative(account: Account, url: string, body?: any): Promise<Cap.HttpHeaders> {
    const headers: Cap.HttpHeaders = {
      'Accept': 'application/json',
    }
    if (url.startsWith(account.url + '/ocs') || url.startsWith(account.url + '/index.php/login/v2')) {
      headers['OCS-APIRequest'] = "true"
    }

    if (account) {
      if (!account.isAuthenticated) {
        return Promise.resolve(null)
      }
      headers['Authorization'] = `Basic ${account.authdata}`
    }
    if (body) {
      headers['Content-Type'] = 'application/json'
    }

    return headers;
  }

}
