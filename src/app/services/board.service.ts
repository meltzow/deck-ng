import { Inject, Injectable, Optional }                      from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams,
         HttpResponse, HttpEvent, HttpParameterCodec, HttpContext
        }       from '@angular/common/http';
import { Observable, throwError } from 'rxjs';

import { BoardItem } from '../model/boardItem';
import { CreateBoardRequest } from '../model/createBoardRequest';

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
     * @param observe set whether or not to return the data Observable as the body, response or events. defaults to returning the body.
     * @param reportProgress flag to report request and response progress.
     */
    public createBoard(createBoardRequest?: CreateBoardRequest): Observable<BoardItem> {
        const localVarHeaders = this.serviceHelper.addDefaultHeaders();

        return this.httpClient.post<BoardItem>(`${this.authService.account.getValue().url}/index.php/apps/deck/api/v1/boards`,
            createBoardRequest,
            {
                context: new HttpContext(),
                responseType: "json",
                withCredentials: false,
                headers: localVarHeaders
            }
        );
    }


    /**
     * Get a board
     * @param boardId Numeric ID of the board to get
     */
    public getBoard(boardId: number): Observable<BoardItem> {
        if (boardId === null || boardId === undefined) {
            throw new Error('Required parameter boardId was null or undefined when calling getBoard.');
        }

        const localVarHeaders = this.serviceHelper.addDefaultHeaders()

        return this.httpClient.get<BoardItem>(`${this.authService.account.getValue().url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}`,
            this.serviceHelper.getHttpOptions()
        );
    }

    /**
     * Get a list of boards
     * @param details
     * @param observe set whether or not to return the data Observable as the body, response or events. defaults to returning the body.
     * @param reportProgress flag to report request and response progress.
     */
    public getBoards(details?: boolean): Observable<Array<BoardItem>> {

        if (details !== undefined && details !== null) {
        //   localVarQueryParameters = this.addToHttpParams(localVarQueryParameters,
        //     <any>details, 'details');
        }

      const localVarHeaders = this.serviceHelper.addDefaultHeaders()

        return this.httpClient.get<Array<BoardItem>>(`${this.authService.account.getValue().url}/index.php/apps/deck/api/v1/boards`,
            this.serviceHelper.getHttpOptions()
        );
    }

}
