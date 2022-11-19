import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';

import { UrlPage } from './url-page.component';
import { AuthenticationService } from "@app/services";

describe('ServerAdressPage', () => {
  let component: UrlPage;
  let fixture: ComponentFixture<UrlPage>;

  beforeEach(waitForAsync(() => {
    const authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])
    // boardServiceSpy.isAuthenticated.and.returnValue(true)

    TestBed.configureTestingModule({
      declarations: [ UrlPage ],
      imports: [IonicModule.forRoot()],
      providers: [{ provide: AuthenticationService, useValue: authServiceSpy }],
    }).compileComponents();

    fixture = TestBed.createComponent(UrlPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

});
