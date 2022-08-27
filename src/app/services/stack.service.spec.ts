import { TestBed } from '@angular/core/testing';

import { StackService } from './stack.service';
import { BoardItem } from "@app/model/boardItem";
import { StackItem } from "@app/model";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { HttpClient } from "@angular/common/http";
import { AuthenticationService } from "@app/services/authentication.service";
import { BehaviorSubject } from "rxjs";
import { ServiceHelper } from "@app/helper/serviceHelper";

describe('StackService', () => {
  let service: StackService;
  let stacks: StackItem[]
  let httpMock: HttpTestingController
  let httpClient: HttpClient
  let authServiceSpy: AuthenticationService

  beforeEach(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
        {provide: ServiceHelper}
      ],
    });
    service = TestBed.inject(StackService);
    httpMock = TestBed.inject(HttpTestingController)
    httpClient = TestBed.inject(HttpClient)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('check getStacks() request for expectations', () => {

    stacks = [{title :'TheCodeBuzz', id: 2131}]
    authServiceSpy.account = new BehaviorSubject({authdata: "foobar", username: 'user', id: 1, url: 'https://foo.bar'})

    service.getStacks(1).subscribe((emp)=>{
      expect(emp).toEqual(stacks);
    });

    const req = httpMock.expectOne('https://foo.bar' + '/index.php/apps/deck/api/v1/boards/1/stacks');
    expect(req.request.method).toEqual("GET")
    expect(req.request.headers.get('Authorization')).toEqual('Basic foobar')
    //this header is not allowed by server see response header Access-Control-Allow-Headers
    expect(req.request.headers.get('OCS-APIRequest')).toBeNull()
    //OPTIONS response header says: "Access-Control-Allow-Credentials: false"
    expect(req.request.withCredentials).toBeFalse()

    req.flush(stacks)

    httpMock.verify();

  });
});
