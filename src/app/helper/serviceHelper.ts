import { Injectable } from "@angular/core";
import { HttpContext, HttpHeaders, HttpParams } from "@angular/common/http";
import { CustomHttpParameterCodec } from "@app/encoder";
import { Account } from "@app/model";

@Injectable({providedIn: 'root'})
export class ServiceHelper {

  public getHttpOptions(account: Account): {
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
      headers: this.addDefaultHeaders(account)
    }
  }

  public addDefaultHeaders(account: Account): HttpHeaders {
    let localVarHeaders = new HttpHeaders();

    const authData = account.authdata
    if (!authData) {
      throw new Error("user is not logged in")
    }

    localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    // localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    return localVarHeaders
  }
}
