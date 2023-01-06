import { TestBed } from '@angular/core/testing';

import { AuthenticationService } from "@app/services";
import { HttpTestingController, HttpClientTestingModule } from '@angular/common/http/testing';
import { BehaviorSubject, of } from "rxjs";
import { Account, Board } from "@app/model";
import { HttpClient } from "@angular/common/http";
import { HttpService } from "@app/services/http.service";

describe('HttpService', () => {
  let service: HttpService;
  let httpMock
  let authServiceSpy

  beforeEach(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['getAccount'])

    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy }
      ],
    });
    service = TestBed.inject(HttpService);
    httpMock = TestBed.inject(HttpTestingController)
  })

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('check request for http expectations', async () => {
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
      const req = httpMock.expectOne('https://foo.bar' + '/foo.html');
      expect(req.request.method).toEqual("GET")
      expect(req.request.headers.get('Authorization')).toEqual('Basic foobar')
      //this header is not allowed by server see response header Access-Control-Allow-Headers
      expect(req.request.headers.get('OCS-APIRequest')).toBeNull()
      //OPTIONS response header says: "Access-Control-Allow-Credentials: false"
      expect(req.request.withCredentials).toBeFalse()
      req.flush(boards)

      httpMock.verify();
    })

    const value = await service.get('foo.html')
    expect(value).toEqual(boards)
  });

  it('deliver empty boards if not logged in', async () => {
    httpMock = TestBed.inject(HttpTestingController)
    authServiceSpy.getAccount.and.returnValue(Promise.resolve())
    authServiceSpy._isAuthSubj = of(false)

    const boards = await service.get<Board[]>('getBoardsUrl')
    expect(boards).toBeDefined()

    httpMock.expectNone('http://localhost:8080/index.php/apps/deck/api/v1/boards');
    httpMock.verify();

  });

});
