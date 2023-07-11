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


  public async post<T>(relativeURL: string, body?: any, withCredentials = true, displayError = true): Promise<T> {
    let account;
    if (withCredentials) {
      try {
        account = await this.authService.getAccount()
      } catch (e) { /* empty */ }
    }
    const url = this.getUrl(relativeURL, account);


    if (this.isNativePlatform()) {
      const headers = await this.getHeadersNative(account, url, body)
      const postoptions: Cap.HttpOptions = {
        url: url.toString(),
        headers: headers,
        data: body
      }

      return new Promise((resolve, reject) => {
        Cap.CapacitorHttp.post(postoptions)
          .then(resp => {
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
        this.httpClient.post<T>(url.toString(),
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

  public async put<T>(relativeURL: string, body: any, withCredentials = true, displayError = true): Promise<T> {
    let account;
    if (withCredentials) {
      try {
        account = await this.authService.getAccount()
      } catch (e) { /* empty */ }
    }
    const url = this.getUrl(relativeURL, account);

    if (this.isNativePlatform()) {
      const headers = await this.getHeadersNative(account, url, body)
      const options: Cap.HttpOptions = {
        url: url.toString(),
        headers: headers,
        data: body
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).put(options)
          .then(resp => {
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
      )
    } else {
      let headers = await this.getHeaders(account, url)
      headers = headers.set('Content-Type', 'application/json');
      return new Promise((resolve, reject) => {
        this.httpClient.put<T>(url.toString(),
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

  public async get<T>(relativeURL: string, withCredentials = true, displayError = true): Promise<T> {
    let account;
    if (withCredentials) {
      try {
        account = await this.authService.getAccount()
      } catch (e) { /* empty */ }
    }
    const url = this.getUrl(relativeURL, account);


    if (this.isNativePlatform()) {
      const options: Cap.HttpOptions = {
        url: url.toString(),
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
        this.httpClient.get<T>(url.toString(), {
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

  public async delete<T>(relativeURL: string, withCredentials = true, displayError = true): Promise<T> {
    let account;
    if (withCredentials) {
      try {
        account = await this.authService.getAccount()
      } catch (e) { /* empty */ }
    }
    const url = this.getUrl(relativeURL, account);

    if (this.isNativePlatform()) {
      const options: Cap.HttpOptions = {
        url: url.toString(),
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
        this.httpClient.delete<T>(url.toString(), {
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

  private async getHeaders(account: Account, url: URL, body?: any): Promise<HttpHeaders> {
    let localVarHeaders = new HttpHeaders();
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');

    if (account) {
      localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + account.authdata);
    }

    if (url.pathname.includes('/ocs') || url.pathname.includes('/index.php/login/v2') || url.pathname.includes('/login/v2')) {
      localVarHeaders = localVarHeaders.set('OCS-APIREQUEST', 'true');
    }
    if (body) {
      localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    }
    return localVarHeaders
  }

  private async getHeadersNative(account: Account, url: URL, body?: any): Promise<Cap.HttpHeaders> {
    const headers: Cap.HttpHeaders = {
      'Accept': 'application/json',
    }
    if (url.pathname.startsWith('/ocs') || url.pathname.startsWith('/index.php/login/v2')) {
      headers['OCS-APIREQUEST'] = "true"
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

  public joinRelativeUrlPath(...args: string[]) {
    return "/" + args.map( pathPart => pathPart.replace(/(^\/|\/$)/g, "") ).join("/");
  }

  private getUrl(relativeURL: string, account?: Account): URL {
    let url, relativePath;
    if (account) {
      if (!relativeURL.startsWith("/"))
        throw new Error('Required parameter relativeURL must start with an "/"');
      const accountURL = new URL(account.url);
      relativePath = this.joinRelativeUrlPath(accountURL.pathname, relativeURL);
      url = new URL(relativePath, accountURL)
    } else {
      url = new URL(relativeURL, 'http://localhost')
    }

    return url;
  }
}
