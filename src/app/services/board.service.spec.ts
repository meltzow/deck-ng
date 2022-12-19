import { fakeAsync, flushMicrotasks, TestBed } from '@angular/core/testing';

import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services/board.service";
import { HttpTestingController, HttpClientTestingModule } from '@angular/common/http/testing';
import { ServiceHelper } from "@app/helper/serviceHelper";
import { BehaviorSubject, of } from "rxjs";
import { Account } from "@app/model";
import { HttpClient } from "@angular/common/http";

describe('BoardService', () => {
  let service: BoardService;
  let httpMock
  let authServiceSpy

  beforeEach(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['getAccount'])
    // httpSpy = jasmine.createSpyObj(HttpClient, ['get'])

    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
        // {provide: HttpClient, useValue: httpSpy},
        {provide: ServiceHelper}
      ],
    });
    service = TestBed.inject(BoardService);
    httpMock = TestBed.inject(HttpTestingController)
  })

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('check getBoards-request for http expectations', async () => {
    // httpMock = TestBed.inject(HttpTestingController)
    const boards = [{title: 'TheCodeBuzz', id: 2131}]
    authServiceSpy.getAccount.and.returnValue(Promise.resolve({
      authdata: "foobar",
      username: 'user',
      id: 1,
      url: 'https://foo.bar',
      isAuthenticated: true
    } as Account))
    authServiceSpy.isAuthSubj = new BehaviorSubject(true)
    authServiceSpy.share = authServiceSpy.isAuthSubj.asObservable();

    //workaround: see https://github.com/angular/angular/issues/25965
    setTimeout(() => {
      const req = httpMock.expectOne('https://foo.bar' + '/index.php/apps/deck/api/v1/boards');
      expect(req.request.method).toEqual("GET")
      expect(req.request.headers.get('Authorization')).toEqual('Basic foobar')
      //this header is not allowed by server see response header Access-Control-Allow-Headers
      expect(req.request.headers.get('OCS-APIRequest')).toBeNull()
      //OPTIONS response header says: "Access-Control-Allow-Credentials: false"
      expect(req.request.withCredentials).toBeFalse()

      req.flush(boards)

      httpMock.verify();
    })

    const value = await service.getBoards()

    expect(value).toEqual(boards)
    expect(service.currentBoards.value).toEqual(boards)
  });

  it('getBoards() deliver empty boards if not logged in', async () => {
    httpMock = TestBed.inject(HttpTestingController)
    authServiceSpy.getAccount.and.returnValue(Promise.resolve())
    authServiceSpy._isAuthSubj = of(false)

    const boards = await service.getBoards()
    expect(boards).toEqual([])

    httpMock.expectNone('http://localhost:8080/index.php/apps/deck/api/v1/boards');
    httpMock.verify();

  });

});
