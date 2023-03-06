import { TestBed } from '@angular/core/testing';

import { CardsService } from './cards.service';
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { AuthenticationService } from "@app/services/authentication.service";
import { Account, Card } from "@app/model"
import { BehaviorSubject, of, timeout } from "rxjs";

describe('CardsService', () => {
  let service: CardsService;
  let authServiceSpy;
  let httpMock

  beforeEach(() => {

    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated','getAccount','getAccountSubj'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
      ]
    });
    service = TestBed.inject(CardsService);
    httpMock = TestBed.inject(HttpTestingController)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it ('test creating a card', async () => {

    const account = {
      authdata: "foobar",
      username: 'admin',
      id: 1,
      url: 'http://localhost:8080',
      isAuthenticated: true
    }

    authServiceSpy.getAccount.and.returnValue(Promise.resolve(account as Account))
    authServiceSpy.getAccountSubj.and.returnValue(new BehaviorSubject(account))

    const card = new Card()
    card.title = "foobar"
    card.id = 11
    const stackId = 10
    const boardId = 11

    setTimeout(() => {
      const req = httpMock.expectOne('/index.php/apps/deck/api/v1/boards/11/stacks/10/cards');

      expect(req.request.method).toEqual("POST")
      expect(req.request.headers.get('Authorization')).toEqual('Basic foobar')
      //this header is not allowed by server see response header Access-Control-Allow-Headers
      expect(req.request.headers.get('OCS-APIRequest')).toBeNull()
      //OPTIONS response header says: "Access-Control-Allow-Credentials: false"
      expect(req.request.withCredentials).toBeFalse()

      req.flush(card)

      httpMock.verify();
    })

    const rCard = await service.createCard(boardId, stackId, card)

    expect(rCard.id).toBeDefined()

  });
});
