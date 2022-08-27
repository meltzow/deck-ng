import { Injectable } from "@angular/core";
import { HttpContext, HttpHeaders, HttpParams } from "@angular/common/http";
import { AuthenticationService } from "@app/services";
import { CustomHttpParameterCodec } from "@app/encoder";

@Injectable()
export class ServiceHelper {

  constructor(private authService: AuthenticationService) {
  }

  public getHttpOptions(): {
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
      headers: this.addDefaultHeaders()
    }
  }

  public addDefaultHeaders(): HttpHeaders {
    let localVarHeaders = new HttpHeaders();

    const authData = this.authService.account && this.authService.account.getValue() ? this.authService.account.getValue().authdata : null
    if (!authData) {
      throw new Error("user is not logged in")
    }

    localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    // localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    return localVarHeaders
  }
}
