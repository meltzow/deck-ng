import { TestBed } from '@angular/core/testing';

import { StackService } from './stack.service';
import { Account, Stack } from "@app/model";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { HttpService } from "@app/services/http.service";

describe('StackService', () => {
  let service: StackService;
  let stacks: Stack[]
  let httpServiceSpy

  beforeEach(() => {
    httpServiceSpy = jasmine.createSpyObj('HttpService',['get'])

    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule],
      providers: [
        { provide: HttpService, useValue: httpServiceSpy },
      ],
    });
    service = TestBed.inject(StackService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

});
