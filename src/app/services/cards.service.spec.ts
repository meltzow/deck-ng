import { fakeAsync, flush, TestBed } from '@angular/core/testing';

import { CardsService } from './cards.service';
import { ServiceHelper } from "@app/helper/serviceHelper";
import { HttpClientTestingModule } from "@angular/common/http/testing";
import { AuthenticationService } from "@app/services/authentication.service";
import { Account, Card } from "@app/model"

describe('CardsService', () => {
  let service: CardsService;
  let authServiceSpy;

  beforeEach(() => {

    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated','getAccount'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: AuthenticationService, useValue: authServiceSpy },
         { provide: ServiceHelper}
      ]
    });
    service = TestBed.inject(CardsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it ('test creating a card', fakeAsync((done: DoneFn) => {

    authServiceSpy.getAccount.and.returnValue(Promise.resolve({
      authdata: "foo",
      username: 'admin',
      id: 1,
      url: 'http://localhost:8080',
      isAuthenticated: true
    } as Account))

    const card = new Card()
    card.title = "foobar"
    const stackId = 10
    const boardId = 11

    let rCard
    service.createCard(boardId, stackId, card).then(respCard => {
      rCard = respCard
    })

    flush();

    expect(rCard.id).toBeDefined()
  }));
});
