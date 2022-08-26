import { Inject, Injectable, Optional }                      from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams,
         HttpResponse, HttpEvent, HttpParameterCodec, HttpContext
        }       from '@angular/common/http';
import { CustomHttpParameterCodec }                          from '../encoder';
import { Observable, throwError } from 'rxjs';

import { BoardItem } from '../model/boardItem';
import { CreateBoardRequest } from '../model/createBoardRequest';

import { BASE_PATH, COLLECTION_FORMATS }                     from '../variables';
import { Configuration }                                     from '../configuration';
import { AuthenticationService } from "@app/services/authentication.service";



@Injectable({
  providedIn: 'root'
})
export class BoardService {

    protected basePath = 'http://localhost:8080/index.php';
    public defaultHeaders = new HttpHeaders();
    public encoder: HttpParameterCodec;

    constructor(protected httpClient: HttpClient, private authService: AuthenticationService) {
        this.encoder =  new CustomHttpParameterCodec();
    }


     /**
     * Create a new board
     * @param createBoardRequest
     * @param observe set whether or not to return the data Observable as the body, response or events. defaults to returning the body.
     * @param reportProgress flag to report request and response progress.
     */
    public createBoard(createBoardRequest?: CreateBoardRequest, observe?: 'body', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<BoardItem>;
    public createBoard(createBoardRequest?: CreateBoardRequest, observe?: 'response', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpResponse<BoardItem>>;
    public createBoard(createBoardRequest?: CreateBoardRequest, observe?: 'events', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpEvent<BoardItem>>;
    public createBoard(createBoardRequest?: CreateBoardRequest, observe: any = 'body', reportProgress = false, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<any> {

        let localVarHeaders = this.defaultHeaders;
        if (!this.authService.account.getValue().authdata) throwError("user is not logged in")
        localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + this.authService.account.getValue().authdata);

        localVarHeaders = localVarHeaders.set('Accept', 'application/json');

        let localVarHttpContext: HttpContext | undefined = options && options.context;
        if (localVarHttpContext === undefined) {
            localVarHttpContext = new HttpContext();
        }


        localVarHeaders = localVarHeaders.set('Content-Type',  'application/json');

        return this.httpClient.post<BoardItem>(`${this.basePath}/apps/deck/api/v1/boards`,
            createBoardRequest,
            {
                context: localVarHttpContext,
                responseType: "json",
                withCredentials: true,
                headers: localVarHeaders,
                observe: observe,
                reportProgress: reportProgress
            }
        );
    }

    /**
     * Get a board
     * @param boardId Numeric ID of the board to get
     * @param observe set whether or not to return the data Observable as the body, response or events. defaults to returning the body.
     * @param reportProgress flag to report request and response progress.
     */
    public getBoard(boardId: number, observe?: 'body', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<BoardItem>;
    public getBoard(boardId: number, observe?: 'response', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpResponse<BoardItem>>;
    public getBoard(boardId: number, observe?: 'events', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpEvent<BoardItem>>;
    public getBoard(boardId: number, observe: any = 'body', reportProgress = false, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<any> {
        if (boardId === null || boardId === undefined) {
            throw new Error('Required parameter boardId was null or undefined when calling getBoard.');
        }

        let localVarHeaders = this.defaultHeaders;

        if (!this.authService.account.getValue().authdata) throwError("user is not logged in")
        localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + this.authService.account.getValue().authdata);

        localVarHeaders = localVarHeaders.set('Accept',  'application/json');

        let localVarHttpContext: HttpContext | undefined = options && options.context;
        if (localVarHttpContext === undefined) {
            localVarHttpContext = new HttpContext();
        }


        return this.httpClient.get<BoardItem>(`${this.basePath}/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}`,
            {
                context: localVarHttpContext,
                responseType: "json",
                withCredentials: true,
                headers: localVarHeaders,
                observe: observe,
                reportProgress: reportProgress
            }
        );
    }

    /**
     * Get a list of boards
     * @param details
     * @param observe set whether or not to return the data Observable as the body, response or events. defaults to returning the body.
     * @param reportProgress flag to report request and response progress.
     */
    public getBoards(details?: boolean, observe?: 'body', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<Array<BoardItem>>;
    public getBoards(details?: boolean, observe?: 'response', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpResponse<Array<BoardItem>>>;
    public getBoards(details?: boolean, observe?: 'events', reportProgress?: boolean, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<HttpEvent<Array<BoardItem>>>;
    public getBoards(details?: boolean, observe: any = 'body', reportProgress = false, options?: {httpHeaderAccept?: 'application/json', context?: HttpContext}): Observable<any> {

        const localVarQueryParameters = new HttpParams({encoder: this.encoder});
        if (details !== undefined && details !== null) {
        //   localVarQueryParameters = this.addToHttpParams(localVarQueryParameters,
        //     <any>details, 'details');
        }

        let localVarHeaders = this.defaultHeaders;

        const authData = this.authService.account && this.authService.account.getValue() ? this.authService.account.getValue().authdata:null
        if (!authData) {
          return throwError("user is not logged in")
        }

        localVarHeaders = localVarHeaders.set('Authorization', 'Basic ' + authData);
        localVarHeaders = localVarHeaders.set('Accept', 'application/json');
        // localVarHeaders = localVarHeaders.set('OCS-APIRequest', 'true');

        let localVarHttpContext: HttpContext | undefined = options && options.context;
        if (localVarHttpContext === undefined) {
            localVarHttpContext = new HttpContext();
        }


        return this.httpClient.get<Array<BoardItem>>(`${this.authService.account.getValue().url}/index.php/apps/deck/api/v1/boards`,
            {
                context: localVarHttpContext,
                params: localVarQueryParameters,
                responseType: 'json',
                withCredentials: false,
                headers: localVarHeaders,
                observe: observe,
                reportProgress: reportProgress
            }
        );
    }

}
