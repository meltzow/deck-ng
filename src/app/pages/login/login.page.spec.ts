import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { Router, RouterModule } from '@angular/router';

import { AuthenticationService, BoardService } from "@app/services";
import { LoginPage } from "@app/pages/login/login.page";
import { FormsModule } from "@angular/forms";
import { TranslateTestingModule } from "ngx-translate-testing";
import { TranslateService } from "@ngx-translate/core";
import { Account } from "@app/model";
import { of } from "rxjs";
import { NotificationService } from "@app/services/notification.service";
import { LoginService } from "@app/services/login.service";


describe('LoginPage', () => {
  let component: LoginPage;
  let fixture: ComponentFixture<LoginPage>;
  let transService: TranslateService
  let authServiceSpy
  let routerSpy
  let notifySpy
  let loginServiceSpy

  beforeEach(waitForAsync(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['getAccount'])
    routerSpy = {navigate: jasmine.createSpy('navigate')};
    notifySpy = jasmine.createSpyObj('NotificationService', ['msg', 'error'])
    loginServiceSpy = jasmine.createSpyObj('LoginService',['login'])

    TestBed.configureTestingModule({
      declarations: [LoginPage],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), FormsModule,
        TranslateTestingModule
          // eslint-disable-next-line @typescript-eslint/no-var-requires
          .withTranslations('de', require('../../../assets/i18n/de.json'))
          // eslint-disable-next-line @typescript-eslint/no-var-requires
          .withTranslations('en', require('../../../assets/i18n/en.json'))
      ],
      providers: [
        {provide: AuthenticationService, useValue: authServiceSpy},
        {provide: Router, useValue: routerSpy},
        {provide: NotificationService, useValue: notifySpy},
        {provide: LoginService, useValue: loginServiceSpy},
      ],
    }).compileComponents();

    transService = TestBed.inject(TranslateService)
    fixture = TestBed.createComponent(LoginPage);

  }));

  it('should create', () => {
    authServiceSpy.getAccount.and.returnValue(Promise.reject('user foo bar'))
    component = fixture.componentInstance;
    fixture.detectChanges();

    expect(component).toBeTruthy();
  });

  it ('nothing happens on login if url is not valid', async () => {
    component = await fixture.componentInstance;
    await fixture.detectChanges();

    const form = component.form
    await component.onLogin(form)

    expect(loginServiceSpy.login).toHaveBeenCalledTimes(0)
  })

  it ('with valid url there is a login try', async () => {
    loginServiceSpy.login.and.returnValue(Promise.resolve(true))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    const form = component.form
    form.controls['url'].setValue("http://foo.bar")
    await component.onLogin(form)

    expect(loginServiceSpy.login).toHaveBeenCalledTimes(1)

  })

  it ('if auth not possible there must be a notification with error', async () => {
    loginServiceSpy.login.and.returnValue(Promise.reject(new Error("url not exists")))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    const form = component.form
    form.controls['url'].setValue("http://foo.bar")
    await component.onLogin(form)

    expect(loginServiceSpy.login).toHaveBeenCalledTimes(1)
    expect(notifySpy.error).toHaveBeenCalledTimes(1)

  })

  it('if account exist then prefill url', async () => {
    const a = new Account()
    a.url = "https://foo.bar"
    authServiceSpy.getAccount.and.returnValue(Promise.resolve(a))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    expect(component.login.url).toEqual(a.url)
  });

  it('if account not exist there is no problem', async () => {
    authServiceSpy.getAccount.and.returnValue(Promise.resolve(null))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    expect(component.login.url).toEqual("")

  });

  it('labels are translated', () => {
    authServiceSpy.getAccount.and.returnValue(Promise.reject('user foo bar'))
    transService.use('de')
    let labels, server_url
    fixture.detectChanges();
    labels = fixture.debugElement.nativeElement.querySelectorAll('ion-label');
    expect(labels.length).toEqual(2)

    server_url = labels[1].textContent;
    expect(server_url).toEqual('Server URL');

    transService.use('en')
    fixture.detectChanges();
    labels = fixture.nativeElement.querySelectorAll('ion-label');
    server_url = labels[1].textContent;
    expect(server_url).toEqual('server URL');


    transService.use('fr')
    fixture.detectChanges();
    labels = fixture.nativeElement.querySelectorAll('ion-label');
    server_url = labels[1].textContent;
    expect(server_url).toEqual('server URL');

  });
});
