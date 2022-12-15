import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';

import { Observable, of } from "rxjs";
import { Board } from "@app/model/board";
import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService, BoardService } from "@app/services";
import { IonicStorageModule } from "@ionic/storage-angular";
import { BoardOverviewPage } from "@app/pages/board/board-overview.page";

describe('BoardOverviewPage', () => {
  let component: BoardOverviewPage;
  let fixture: ComponentFixture<BoardOverviewPage>;
  let authServiceSpy

  beforeEach(waitForAsync(() => {
    const boardServiceSpy = jasmine.createSpyObj('BoardService',['getBoards','getBoardsProm'])
    authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated', 'ngOnInit'])

    TestBed.configureTestingModule({
      declarations: [ BoardOverviewPage ],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), HttpClientModule, IonicStorageModule.forRoot()],
      providers: [
        { provide: BoardService, useValue: boardServiceSpy },
        { provide: AuthenticationService, useValue: authServiceSpy },
      ],
    }).compileComponents();

    // boardServiceSpy.getBoards.and.returnValue(Promise.resolve([{title: 'foobar'}]))
    boardServiceSpy.getBoards.and.returnValue(of([{title: 'foobar'}]))

    fixture = TestBed.createComponent(BoardOverviewPage);
    component = fixture.componentInstance;
    fixture.detectChanges();

    component.ngOnInit()
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  // describe('test', ()=> {
  //   it('should display list of boards', () => {
  //
  //     fixture.detectChanges();
  //     const boardItem = {title: 'foobob'}
  //     component.boards = new BehaviorSubject<BoardItem[]>([boardItem])
  //
  //     const h2 = fixture.debugElement.nativeElement.querySelectorAll('ion-col');
  //     expect(h2.length).toEqual(1);
  //
  //     const content = h2[0].innerText;
  //     expect(h2[0]).toBeTruthy();
  //
  //     // expect(content)
  //     //   .toContain('foobob');
  //
  //   });
  // })
});
