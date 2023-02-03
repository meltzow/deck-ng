import { Injectable } from '@angular/core';
import { BehaviorSubject, } from 'rxjs';

import { Board, CreateBoardRequest } from '@app/model';

import { HttpService } from "@app/services/http.service";


@Injectable({
  providedIn: 'root'
})
export class BoardService {
  currentBoardsSubj:BehaviorSubject<Board[]> = new BehaviorSubject<Board[]>([])

  constructor(private httpService: HttpService) {
  }


  /**
   * Create a new board
   * @param createBoardRequest
   */
  public createBoard(createBoardRequest?: CreateBoardRequest): Promise<Board> {
      return this.httpService.post<Board>(`/index.php/apps/deck/api/v1/boards`, createBoardRequest)
  }


  /**
   * Get a board
   * @param boardId Numeric ID of the board to get
   */
  public getBoard(boardId: number): Promise<Board> {
    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getBoard.');
    }

      return this.httpService.get<Board>(`/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}`)
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
