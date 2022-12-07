import { TestBed } from '@angular/core/testing';

import { StackService } from './stack.service';
import { Account, StackItem } from "@app/model";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper";

describe('StackService', () => {
  let service: StackService;
  let stacks: StackItem[]
  let httpMock: HttpTestingController
  let authServiceSpy

  beforeEach(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['getAccount'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
        {provide: ServiceHelper}
      ],
    });
    service = TestBed.inject(StackService);
    httpMock = TestBed.inject(HttpTestingController)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('check getStacks() request for expectations',  async () => {

    stacks = [{title :'TheCodeBuzz', id: 2131}]
    authServiceSpy.getAccount.and.returnValue(Promise.resolve({authdata: "foobar", username: 'user', id: 1, url: 'https://foo.bar',isAuthenticated: true } as Account))

   await service.getStacks(1).subscribe((emp)=>{
      expect(emp).toEqual(stacks);
    })
     // .catch(reason => expect(reason).toEqual('user not auth'))

    const req = httpMock.expectOne('https://foo.bar/index.php/apps/deck/api/v1/boards/1/stacks');

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
