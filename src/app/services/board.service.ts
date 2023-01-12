import { Injectable } from '@angular/core';
import { HttpClient, HttpContext } from '@angular/common/http';
import { BehaviorSubject, firstValueFrom } from 'rxjs';

import { Board, CreateBoardRequest } from '@app/model';

import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper"
import { HttpService } from "@app/services/http.service";


@Injectable({
  providedIn: 'root'
})
export class BoardService {
  currentBoardsSubj:BehaviorSubject<Board[]> = new BehaviorSubject<Board[]>([])

  constructor(protected httpClient: HttpClient,
              private authService: AuthenticationService,
              private serviceHelper: ServiceHelper,
              private httpService: HttpService) {
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
  public async getBoards(): Promise<Board[]> {
    const boards = await this.httpService.get<Board[]>('index.php/apps/deck/api/v1/boards')
    this.currentBoardsSubj.next(boards)
    return boards
  }

  public get currentBoards(): BehaviorSubject<Board[]> {
    return this.currentBoardsSubj
  }

}
