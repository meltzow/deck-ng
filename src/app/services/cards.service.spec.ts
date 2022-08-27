import { TestBed } from '@angular/core/testing';

import { CardsService } from './cards.service';
import { ServiceHelper } from "@app/helper/serviceHelper";
import { HttpClientTestingModule } from "@angular/common/http/testing";
import { AuthenticationService } from "@app/services/authentication.service";

describe('CardsService', () => {
  let service: CardsService;
  let authServiceSpy;

  beforeEach(() => {

    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])

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
});
