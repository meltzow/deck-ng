import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';

import { AuthenticationService } from "@app/services";
import { BarcodePage } from "@app/pages/login/barcode/barcode.page";

describe('BarcodePage', () => {
  let component: BarcodePage;
  let fixture: ComponentFixture<BarcodePage>;

  beforeEach(waitForAsync(() => {
    const authServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])
    // boardServiceSpy.isAuthenticated.and.returnValue(true)

    TestBed.configureTestingModule({
      declarations: [ BarcodePage ],
      imports: [IonicModule.forRoot()],
      providers: [{ provide: AuthenticationService, useValue: authServiceSpy }],
    }).compileComponents();

    fixture = TestBed.createComponent(BarcodePage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it ('barcode is parseable', () => {
    const content = "nc://login/user:foo&password:bar&server:https://my.nextcloud.org"
    component.parseContent(content)

    expect(component.barcode.url).toEqual("https://my.nextcloud.org")
    expect(component.barcode.user).toEqual("foo")
    expect(component.barcode.password).toEqual("bar")
  })
});
