import { Injectable } from '@angular/core';
import { HttpClient, HttpContext, HttpHeaders, HttpParams, } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

import { Account, UpcomingResponse } from '@app/model';

import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper"
import { Platform } from "@ionic/angular";
import { CapacitorHttp } from "@capacitor/core";
import { CustomHttpParameterCodec } from "@app/encoder";


@Injectable({
  providedIn: 'root'
})
export class HttpService {

  constructor(protected httpClient: HttpClient,
              private authService: AuthenticationService,
              private platform: Platform) {
  }


  /**
   * Get a list of boards
   *
   */
  public async get<T>(url: string): Promise<T> {
    const account = await this.authService.getAccount()
    // if (!account || !account.isAuthenticated) {
    //   return Promise.resolve(new ())
    // }

    if (this.platform.is("mobile")) {
      const options = {
        url: `${account.url}/${url}`,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Basic ${account.authdata}`,
          'OCS-APIRequest': 'true'
        },
      };

      return new Promise((resolve, reject) =>
       CapacitorHttp.get(options)
         .then(value => {
           resolve(value.data as T)
         }).catch(reason => {
           console.error(reason)
           reject(reason)
         })
      )
    } else {
      //it must be on desktop
      return new Promise((resolve, reject) =>
        this.httpClient.get<T>(`/${url}`,
          this.getHttpOptions(account, url.startsWith('ocs'))
        ).subscribe({
          next: (value) => {
            resolve(value)
          },
          error: error => reject(error)
        })
      )
    }

  }

  private getHttpOptions(account: Account, isOCSRequest = false ): {
    headers?: HttpHeaders | {
      [header: string]: string | string[];
    };
    context?: HttpContext;
    observe?: 'body';
    params?: HttpParams | {
      [param: string]: string | number | boolean | ReadonlyArray<string | number | boolean>;
    };
    reportProgress?: boolean;
    responseType?: 'json';
    withCredentials?: boolean;
  } {
    return {
      context: new HttpContext(),
      params: new HttpParams({encoder: new CustomHttpParameterCodec()}),
      responseType: 'json',
      withCredentials: false,
      headers: this.addDefaultHeaders(account, isOCSRequest)
    }
  }

  private addDefaultHeaders(account: Account, isOCSRequest = false): HttpHeaders {
    let localVarHeaders = new HttpHeaders();

    const authData = account.authdata
    if (!authData || !account.isAuthenticated) {
      throw new Error("user is not logged in")
    }

    localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    if (isOCSRequest) {
      localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    }
    return localVarHeaders
  }

}
