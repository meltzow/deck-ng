import { fakeAsync, flushMicrotasks, TestBed } from '@angular/core/testing';

import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services/board.service";
import { HttpTestingController, HttpClientTestingModule } from '@angular/common/http/testing';
import { HttpService } from "@app/services/http.service";

describe('BoardService', () => {
  let service: BoardService;
  let httpServiceSpy

  beforeEach(() => {
    httpServiceSpy = jasmine.createSpyObj('HttpService', ['get'])
    const authServiceSpy = jasmine.createSpyObj("AuthenticationService", ['getAccount'])

    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [
        { provide: HttpService, useValue: httpServiceSpy },
        { provide: AuthenticationService, useValue: authServiceSpy },
      ],
    });
    service = TestBed.inject(BoardService);
  })

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

});
