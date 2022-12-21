import { Injectable } from "@angular/core";
import { HttpClient, HttpHeaders } from "@angular/common/http";
import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { from, Observable, switchMap } from "rxjs";
import { Account, Stack } from "@app/model";

@Injectable({
  providedIn: 'root'
})
export class ConfigService {

  constructor(protected httpClient: HttpClient, private authService: AuthenticationService, private serviceHelper: ServiceHelper) {
  }

  public readConfig(boardId?: number): Observable<config> {
    const promiseObservable = from(this.authService.getAccount())
    return promiseObservable.pipe(
      switchMap((account) => {
        return this.httpClient.get<config>(`${account.url}/remote.php/dav/files/${account.username}/Deck/foobar.json`,
          this.serviceHelper.getHttpOptions(account)
        );
      })
    )
  }

  public writeConfig(config: config): Observable<config> {
    const promiseObservable = from(this.authService.getAccount())
    return promiseObservable.pipe(
      switchMap((account) => {
        return this.httpClient.put<config>(`${account.url}/remote.php/dav/files/${account.username}/Deck/foobar.json`,
          config,
          {headers: this.addDefaultHeaders(account)}
        );
      })
    )
  }

  private addDefaultHeaders(account: Account): HttpHeaders {
    let localVarHeaders = new HttpHeaders();

    const authData = account.authdata
    if (!authData || !account.isAuthenticated) {
      throw new Error("user is not logged in")
    }

    localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
    localVarHeaders = localVarHeaders.set('Accept', 'application/json');
    localVarHeaders = localVarHeaders.set('Content-Type', 'application/json');
    localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');
    return localVarHeaders
  }
}

export class config {
  bar: boolean
  age: number
}
