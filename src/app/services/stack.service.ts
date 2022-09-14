import { Injectable } from '@angular/core';
import { HttpClient} from "@angular/common/http";
import { from, Observable, switchMap } from "rxjs";
import { StackItem } from "@app/model";
import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper";

@Injectable({
  providedIn: 'root'
})
export class StackService {

  constructor(protected httpClient: HttpClient, private authService: AuthenticationService, private serviceHelper: ServiceHelper) {
  }

  public getStacks(boardId: number): Observable<Array<StackItem>> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getStacks.')
    }

    const promiseObservable = from(this.authService.getAccount())
    return promiseObservable.pipe(
        switchMap((account) => {
          return this.httpClient.get<Array<StackItem>>(`${account.url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}/stacks`,
            this.serviceHelper.getHttpOptions(account)
          );
        })
      )
  }
}
