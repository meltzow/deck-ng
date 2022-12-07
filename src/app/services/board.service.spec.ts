import { fakeAsync, flush, TestBed, tick, waitForAsync } from '@angular/core/testing';

import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services/board.service";
import { HttpTestingController, HttpClientTestingModule } from '@angular/common/http/testing';
import { HttpClient } from "@angular/common/http";
import { BoardItem } from "@app/model/boardItem";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { BehaviorSubject, from, Observable, of, share } from "rxjs";
import { Account } from "@app/model";

describe('BoardService', () => {
  let service: BoardService;
  let httpMock: HttpTestingController
  let authServiceSpy

  beforeEach(() => {

    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['getAccount'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
        { provide: ServiceHelper}
      ],
    });
    service = TestBed.inject(BoardService);
    httpMock = TestBed.inject(HttpTestingController)
  })

    it('should be created', () => {
      expect(service).toBeTruthy();
    });

  it('check getBoards() request for expectations', async () => {

    const boards = [{title :'TheCodeBuzz', id: 2131}]
    authServiceSpy.getAccount.and.returnValue(Promise.resolve({authdata: "foobar", username: 'user', id: 1, url: 'https://foo.bar', isAuthenticated: true } as Account))
    authServiceSpy.isAuthSubj = new BehaviorSubject(true)
    authServiceSpy.share = authServiceSpy.isAuthSubj.asObservable();

    await service.getBoards().subscribe((emp)=>{
      expect(emp).toEqual(boards);
    });

    const req = httpMock.expectOne('https://foo.bar' + '/index.php/apps/deck/api/v1/boards');
    expect(req.request.method).toEqual("GET")
    expect(req.request.headers.get('Authorization')).toEqual('Basic foobar')
    //this header is not allowed by server see response header Access-Control-Allow-Headers
    expect(req.request.headers.get('OCS-APIRequest')).toBeNull()
    //OPTIONS response header says: "Access-Control-Allow-Credentials: false"
    expect(req.request.withCredentials).toBeFalse()

    req.flush(boards)

    httpMock.verify();

  });

  it('PROMISE check getBoards() request for expectations', fakeAsync((done: DoneFn) => {

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

    service.getBoardsProm().then(value => {
      expect(value).toEqual(boards)
    })
    // const emp = prom

    flush();
    // tick();

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
  );

  it('getBoards() deliver empty boards if not logged in', async () => {

    authServiceSpy.getAccount.and.returnValue(Promise.resolve())
    authServiceSpy._isAuthSubj = of(false)

    await service.getBoards().subscribe(boards => {
      expect(boards).toEqual([])
    })

    httpMock.expectNone('http://localhost:8080/index.php/apps/deck/api/v1/boards');
    httpMock.verify();

  });

  // it('should timeout with Promise+clock', (done: DoneFn): void => {
  //   authServiceSpy.getAccount.and.returnValue(Promise.reject('user foo bar'))
  //
  //   jasmine.clock().install();
  //   service.getBoards().then((value) => {
  //       done.fail('was supposed to timeout error');
  //     }).catch((error) => {
  //       expect(error).toEqual('user foo bar');
  //       done();
  //     }
  //   );
  //   jasmine.clock().tick(3000);
  //   jasmine.clock().uninstall()
  //
  //   httpMock.expectNone('http://localhost:8080/index.php/apps/deck/api/v1/boards');
  //   httpMock.verify();
  // });

});
