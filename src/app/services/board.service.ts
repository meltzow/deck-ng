import { Injectable } from '@angular/core';
import { HttpClient, HttpContext } from '@angular/common/http';
import { BehaviorSubject, firstValueFrom, flatMap, from, Observable, switchMap, tap, of } from 'rxjs';

import { BoardItem, CreateBoardRequest } from '@app/model';

import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper"


@Injectable({
  providedIn: 'root'
})
export class BoardService {

  constructor(protected httpClient: HttpClient, private authService: AuthenticationService, private serviceHelper: ServiceHelper) {
  }


  /**
   * Create a new board
   * @param createBoardRequest
   */
  public createBoard(createBoardRequest?: CreateBoardRequest): Promise<BoardItem> {
    return this.authService.getAccount().then((account) => {
      return firstValueFrom(this.httpClient.post<BoardItem>(`${account.url}/index.php/apps/deck/api/v1/boards`,
        createBoardRequest,
        {
          context: new HttpContext(),
          responseType: "json",
          withCredentials: false,
          headers: this.serviceHelper.addDefaultHeaders(account)
        }
      ))
    })
  }


  /**
   * Get a board
   * @param boardId Numeric ID of the board to get
   */
  public getBoard(boardId: number): Promise<BoardItem> {
    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getBoard.');
    }

    return this.authService.getAccount().then((account) => {
      return firstValueFrom(this.httpClient.get<BoardItem>(`${account.url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}`,
        this.serviceHelper.getHttpOptions(account)
      ))
    })
  }

  /**
   * Get a list of boards
   * @param details
   */
  public getBoards(): Observable<Array<BoardItem>> {
    const promiseObservable = from(this.authService.getAccount())
    return promiseObservable.pipe(
      switchMap((account) => {
        return this.httpClient.get<Array<BoardItem>>(`${account.url}/index.php/apps/deck/api/v1/boards`,
          this.serviceHelper.getHttpOptions(account)
        );
      })
    )
  }

}
