import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';

import { HomePage } from './home.page';
import { Observable } from "rxjs";
import { BoardItem } from "@app/model/boardItem";
import { HttpClientModule } from "@angular/common/http";
import { BoardService } from "@app/services";
import { IonicStorageModule } from "@ionic/storage-angular";

describe('HomePage', () => {
  let component: HomePage;
  let fixture: ComponentFixture<HomePage>;
  let h2: HTMLElement;

  beforeEach(waitForAsync(() => {
    const boardServiceSpy = jasmine.createSpyObj('BoardService',['getBoards'])

    TestBed.configureTestingModule({
      declarations: [ HomePage ],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), HttpClientModule, IonicStorageModule.forRoot()],
      providers: [{ provide: BoardService, useValue: boardServiceSpy }],
    }).compileComponents();

    boardServiceSpy.getBoards.and.returnValue(Promise.resolve([{title: 'foobar'}]))

    fixture = TestBed.createComponent(HomePage);
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
