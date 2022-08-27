import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { TestBed, waitForAsync } from '@angular/core/testing';

import { IonicModule } from "@ionic/angular";
import { RouterModule } from "@angular/router";
import { IonicStorageModule } from "@ionic/storage";
import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services/board.service";
import { HttpTestingController, HttpClientTestingModule } from '@angular/common/http/testing';
import { HttpClient } from "@angular/common/http";
import { BoardItem } from "@app/model/boardItem";
import { BehaviorSubject } from "rxjs";
import { Account } from "@app/model";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { AppComponent } from "@app/app.component";

describe('BoardService', () => {
  let service: BoardService;
  let boards: BoardItem[]
  let httpMock: HttpTestingController
  let httpClient: HttpClient
  let authServiceSpy: AuthenticationService

  beforeEach(waitForAsync(() => {

    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
        { provide: ServiceHelper}
      ],
    });
    service = TestBed.inject(BoardService);
    httpMock = TestBed.inject(HttpTestingController)
    httpClient = TestBed.inject(HttpClient)

  //   TestBed.configureTestingModule({
  //     declarations: [BoardService],
  //     schemas: [CUSTOM_ELEMENTS_SCHEMA],
  //     imports: [IonicModule.forRoot(), MessageComponentModule, RouterModule.forRoot([]), IonicStorageModule.forRoot()],
  //     providers: [{ provide: AuthenticationService, useValue: authServiceSpy }],
  //   }).compileComponents();
  }));

    it('should be created', () => {
      expect(service).toBeTruthy();
    });

  it('check getBoards() request for expectations', () => {

    boards = [{title :'TheCodeBuzz', id: 2131}]
    authServiceSpy.account = new BehaviorSubject({authdata: "foobar", username: 'user', id: 1, url: 'https://foo.bar'})

    service.getBoards().subscribe((emp)=>{
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

  it('getBoards() ist not allowed if not logged in', () => {

    (authServiceSpy.isAuthenticated as any).and.returnValue(false)
    authServiceSpy.account = new BehaviorSubject(null)
    try {
      service.getBoards().subscribe((emp)=>{
        console.log("no op")
        fail("ist not allowed")
      }, error => {
        console.log("error ist handled")
      });
      fail("no error was thrown")
    } catch (exception) {
      expect(exception.message).toEqual("user is not logged in")
    }


    httpMock.expectNone('http://localhost:8080/index.php/apps/deck/api/v1/boards');
    httpMock.verify();

  });

});
