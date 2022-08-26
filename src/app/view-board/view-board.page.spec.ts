import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { ActivatedRoute, convertToParamMap, RouterModule } from '@angular/router';
import { ViewBoardPageRoutingModule } from './view-board-routing.module';

import { ViewBoardPage } from './view-board.page';
import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService, BoardService, StackService } from "@app/services";
import { Observable } from "rxjs";
import { BoardItem } from "@app/model/boardItem";
import { StackItem } from "@app/model";

describe('ViewBoardPage', () => {
  let component: ViewBoardPage;
  let fixture: ComponentFixture<ViewBoardPage>;
  let boardServiceSpy: any
  let stackServiceSpy: any

  beforeEach(waitForAsync(() => {

    boardServiceSpy = jasmine.createSpyObj('BoardService',['getBoard'])
    stackServiceSpy = jasmine.createSpyObj('StackService',['getStacks'])

    TestBed.configureTestingModule({
      declarations: [ ViewBoardPage ],
      imports: [IonicModule.forRoot(), ViewBoardPageRoutingModule, RouterModule.forRoot([]), HttpClientModule],
      providers: [
        { provide: BoardService, useValue: boardServiceSpy },
        { provide: StackService, useValue: stackServiceSpy },
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
    boardServiceSpy.getBoard.and.returnValue(new Observable<BoardItem>((observer) => {
      // observable execution
      observer.next({title: 'foobar', id: 1});
      observer.complete();
    }));
    stackServiceSpy.getStacks.and.returnValue(new Observable<StackItem[]>((observer) => {
      // observable execution
      observer.next([{title: 'foobar', id: 1}]);
      observer.complete();
    }));

    fixture = TestBed.createComponent(ViewBoardPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {

    expect(component).toBeTruthy();
  });

});
