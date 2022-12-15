import { Injectable } from '@angular/core';
import { HttpClient, HttpContext } from '@angular/common/http';
import { BehaviorSubject, firstValueFrom, from, Observable, switchMap, of } from 'rxjs';

import { Board, CreateBoardRequest } from '@app/model';

import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper"


@Injectable({
  providedIn: 'root'
})
export class BoardService {
  currentBoardsSubj = new BehaviorSubject<Board[]>([])
  constructor(protected httpClient: HttpClient, private authService: AuthenticationService, private serviceHelper: ServiceHelper) {
  }


  /**
   * Create a new board
   * @param createBoardRequest
   */
  public createBoard(createBoardRequest?: CreateBoardRequest): Promise<Board> {
    return this.authService.getAccount().then((account) => {
      return firstValueFrom(this.httpClient.post<Board>(`${account.url}/index.php/apps/deck/api/v1/boards`,
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
  public getBoard(boardId: number): Promise<Board> {
    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getBoard.');
    }

    return this.authService.getAccount().then((account) => {
      return firstValueFrom(this.httpClient.get<Board>(`${account.url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}`,
        this.serviceHelper.getHttpOptions(account)
      ))
    })
  }

  /**
   * Get a list of boards
   *
   */
  public async getBoardsProm(): Promise<Array<Board>> {
    const account = await this.authService.getAccount()
    if (!account || !account.isAuthenticated) {
      return Promise.resolve([])
    }
    return new Promise((resolve, reject) =>
        this.httpClient.get<Array<Board>>(`${account.url}/index.php/apps/deck/api/v1/boards`,
          this.serviceHelper.getHttpOptions(account)
        ).subscribe(value => {
          this.currentBoardsSubj.next(value)
          resolve(value)
        }, error => reject(error))
    )
  }

  public get currentBoards(): BehaviorSubject<Board[]> {
    return this.currentBoardsSubj
  }

}
