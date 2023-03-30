import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { ActivatedRoute, convertToParamMap, RouterModule } from '@angular/router';

import { BoardDetailsPage } from './board-details.page';
import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService, BoardService, StackService } from "@app/services";
import {BehaviorSubject, of} from "rxjs";
import { BoardDetailsPageRoutingModule } from "@app/pages/board-details/board-details-routing.module";
import { TranslateModule } from "@ngx-translate/core";

describe('BoardDetailsPage', () => {
  let component: BoardDetailsPage;
  let fixture: ComponentFixture<BoardDetailsPage>;
  let boardServiceSpy
  let stackServiceSpy
  let authServiceSpy

  beforeEach(waitForAsync(() => {

    boardServiceSpy = jasmine.createSpyObj('BoardService',['getBoard'])
    stackServiceSpy = jasmine.createSpyObj('StackService',['getStacks'])
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['login','getAccount','isAuthObs'])


    TestBed.configureTestingModule({
      declarations: [ BoardDetailsPage ],
      imports: [IonicModule.forRoot(), BoardDetailsPageRoutingModule, RouterModule.forRoot([]), HttpClientModule, TranslateModule.forRoot()],
      providers: [
        { provide: BoardService, useValue: boardServiceSpy },
        { provide: StackService, useValue: stackServiceSpy },
        { provide: AuthenticationService, useValue: authServiceSpy},
        {
          provide: ActivatedRoute,
          useValue: {
            snapshot: {
              paramMap: convertToParamMap({
                id: '1'
              })
            }
          }
        }
      ],
    }).compileComponents();
    boardServiceSpy.getBoard.and.returnValue(Promise.resolve({title: 'foobar', id: 1}))
    stackServiceSpy.getStacks.and.returnValue(Promise.resolve([{title: 'first', id: 2},{title: 'second', id: 1} ]))

    fixture = TestBed.createComponent(BoardDetailsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('must select first stack', async () => {
    fixture.detectChanges();

    await component.ionViewWillEnter()

    expect(component.selectedIdx).toEqual(0);
  });

});
