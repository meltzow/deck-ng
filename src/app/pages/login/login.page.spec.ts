import { ComponentFixture, fakeAsync, TestBed, tick, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';

import { AuthenticationService } from "@app/services";
import { LoginPage } from "@app/pages/login/login.page";
import { FormsModule } from "@angular/forms";
import { TranslateTestingModule } from "ngx-translate-testing";
import { TranslateService } from "@ngx-translate/core";


describe('Login', () => {
  let component: LoginPage;
  let fixture: ComponentFixture<LoginPage>;
  let transService: TranslateService

  beforeEach(waitForAsync(() => {
    const authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['login'])

    TestBed.configureTestingModule({
      declarations: [LoginPage],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), FormsModule,
        TranslateTestingModule
          // eslint-disable-next-line @typescript-eslint/no-var-requires
          .withTranslations('de', require('../../../assets/i18n/de.json'))
          // eslint-disable-next-line @typescript-eslint/no-var-requires
          .withTranslations('en', require('../../../assets/i18n/en.json'))
      ],
      providers: [{provide: AuthenticationService, useValue: authServiceSpy}],
    }).compileComponents();

    transService = TestBed.inject(TranslateService)
    fixture = TestBed.createComponent(LoginPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('labels are translated', () => {
    transService.use('de')
    let labels, server_url
    fixture.detectChanges();
    labels = fixture.debugElement.nativeElement.querySelectorAll('ion-label');
    expect(labels.length).toEqual(3)

    server_url = labels[0].textContent;
    expect(server_url).toEqual('Server URL');

    transService.use('en')
    fixture.detectChanges();
    labels = fixture.nativeElement.querySelectorAll('ion-label');
    server_url = labels[0].textContent;
    expect(server_url).toEqual('server URL');


    transService.use('fr')
    fixture.detectChanges();
    labels = fixture.nativeElement.querySelectorAll('ion-label');
    server_url = labels[0].textContent;
    expect(server_url).toEqual('server URL');

  });
});
