import { Injectable } from '@angular/core';
import {
  HttpClient,
  HttpContext,
  HttpEvent,
  HttpHeaders,
  HttpParameterCodec,
  HttpParams,
  HttpResponse
} from "@angular/common/http";
import { Observable, throwError } from "rxjs";
import { StackItem } from "@app/model";
import { AuthenticationService } from "@app/services/authentication.service";
import { CustomHttpParameterCodec } from "@app/encoder";

@Injectable({
  providedIn: 'root'
})
export class StackService {

  public defaultHeaders = new HttpHeaders();
  public encoder: HttpParameterCodec;

  constructor(protected httpClient: HttpClient, private authService: AuthenticationService) {
    this.encoder =  new CustomHttpParameterCodec();
  }

  public getStacks(boardId: number): Observable<Array<StackItem>> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getStacks.');
    }

    let localVarHeaders = this.defaultHeaders;
    const authData = this.authService.account && this.authService.account.getValue() ? this.authService.account.getValue().authdata:null
    if (!authData) {
      return throwError("user is not logged in")
    }

    localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');

    return this.httpClient.get<Array<StackItem>>(`${this.authService.account.getValue().url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}/stacks`,
      {
        context: new HttpContext(),
        params: new HttpParams({encoder: this.encoder}),
        responseType: 'json',
        withCredentials: false,
        headers: localVarHeaders,
      }
    );
  }
}
