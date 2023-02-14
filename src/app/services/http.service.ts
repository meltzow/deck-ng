import { Injectable } from '@angular/core';
import { HttpClient, HttpContext, HttpHeaders, HttpParams, HttpResponse, } from '@angular/common/http';

import { AuthenticationService } from "@app/services/authentication.service";
import { Platform } from "@ionic/angular";
import * as Cap from "@capacitor/core";
import { firstValueFrom } from "rxjs";
import { CapacitorHttpPlugin } from "@capacitor/core/types/core-plugins";
import { askQuestion } from "@angular/cli/src/utilities/prompt";


interface options {
  withCredentials?: boolean
}

@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(protected httpClient: HttpClient,
              private authService: AuthenticationService,
              private platform: Platform) {
  }

  private async getHeaders(withCredentials: boolean): Promise<Cap.HttpHeaders> {
    const headers: Cap.HttpHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'OCS-APIRequest': 'true'
    }
    if (withCredentials) {
      const account = await this.authService.getAccount()
      if (!account || !account.isAuthenticated) {
        return Promise.resolve(null)
      }
      headers['Authorization'] = `Basic ${account.authdata}`
    }
    return headers;
  }

  public async postResponse<T>(url: string, body?: any, options: options = {withCredentials: true}): Promise<HttpResponse<T>> {
    if (this.platform.is("mobile")) {
      const postoptions = {
        url: url,
        headers: await this.getHeaders(options.withCredentials),
        data: body
      }

      const resp1 = await Cap.CapacitorHttp.post(postoptions)
        .catch(reason => {
          console.error(reason)
        })
    } else {
      const headers = await this.addDefaultHeaders(options.withCredentials, url.startsWith('ocs'))
      return firstValueFrom(this.httpClient.post<T>(url,
        body,
        {observe: "response", headers: headers}
      ))
    }
  }

  public async post<T>(url: string, body?: any, options: options = {
    withCredentials: true,
  }): Promise<T> {
    if (this.platform.is("mobile")) {
      const postoptions = {
        url: url,
        headers: await this.getHeaders(options.withCredentials),
        data: body
      }

      const resp1 = await Cap.CapacitorHttp.post(postoptions)
      // .catch(reason => {
      //   console.error(reason)
      // })
      return resp1.data
    } else {
      const headers = await this.addDefaultHeaders(options.withCredentials, url.startsWith('ocs'))
      return firstValueFrom(this.httpClient.post<T>(url,
        body,
        {headers: headers}
      ))
    }
  }

  public async put<T>(url: string, body: any, options1: options = {withCredentials: true}): Promise<T> {
    if (this.platform.is("mobile")) {
      const options = {
        url: url,
        headers: await this.getHeaders(options1.withCredentials),
        data: body
      };
      return new Promise((resolve, reject) =>
        (Cap.CapacitorHttp as CapacitorHttpPlugin).put(options)
          .then(value => {
            resolve(value.data as T)
          }).catch(reason => {
          console.error(reason)
          reject(reason)
        })
      )
    } else {
      const headers = await this.addDefaultHeaders(options1.withCredentials, url.startsWith('ocs'))
      return firstValueFrom(this.httpClient.put<T>(`/${url}`,
        body,
        {headers: headers}
      ))
    }

  }

  public async get<T>(url: string, options1: options = {withCredentials: true}): Promise<T> {
    if (options1.withCredentials ) {
      const isAuth = await this.authService.isAuthenticated()
      if (!isAuth) {
        return Promise.resolve({} as T)
      }
    }

    if (this.platform.is("mobile")) {
      const options = {
        url: url,
        headers: await this.getHeaders(options1.withCredentials),
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
      const headers = await this.addDefaultHeaders(options1.withCredentials, url.startsWith('ocs'))
      return firstValueFrom(this.httpClient.get<T>(`/${url}`, {
        observe: 'body',
        responseType: 'json',
        headers: headers
      }))
    }

  }

  private async getHttpOptions(withCredentials: boolean, isOCSRequest = false): Promise<{
    headers?: HttpHeaders | {
      [header: string]: string | string[];
    };
    observe?: 'body' | 'response';
    params?: HttpParams | {
      [param: string]: string | number | boolean | ReadonlyArray<string | number | boolean>;
    };
    responseType?: 'json';
    withCredentials?: boolean;
  }> {
    return {
      responseType: 'json',
      withCredentials: false,
      headers: await this.addDefaultHeaders(withCredentials, isOCSRequest)
    }
  }

  private async addDefaultHeaders(withCredentials: boolean, isOCSRequest = false): Promise<HttpHeaders> {
    let localVarHeaders = new HttpHeaders();

    if (withCredentials) {
      const account = await this.authService.getAccount()
      if (!account || !account.isAuthenticated) {
        return Promise.resolve(null)
      }
      //TODO handle this with Promise
      const authData = account.authdata
      if (!authData || !account.isAuthenticated) {
        throw new Error("user is not logged in")
      }
      localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    }

    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    if (isOCSRequest) {
      localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    }
    return localVarHeaders
  }

}
