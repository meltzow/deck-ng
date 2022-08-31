import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';

import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService } from "@app/services";
import { IonicStorageModule } from "@ionic/storage-angular";
import { LoginPage } from "@app/pages/login/login.page";
import { FormsModule } from "@angular/forms";


describe('Login', () => {
  let component: LoginPage;
  let fixture: ComponentFixture<LoginPage>;
  let h2: HTMLElement;

  beforeEach(waitForAsync(() => {
    const authServiceSpy = jasmine.createSpyObj('AuthenticationService',['login'])

    TestBed.configureTestingModule({
      declarations: [ LoginPage ],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), FormsModule],
      providers: [{ provide: AuthenticationService, useValue: authServiceSpy }],
    }).compileComponents();

    fixture = TestBed.createComponent(LoginPage);
    component = fixture.componentInstance;
    fixture.detectChanges();

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
