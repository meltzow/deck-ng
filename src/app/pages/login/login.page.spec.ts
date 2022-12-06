import { ComponentFixture, fakeAsync, TestBed, tick, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { Router, RouterModule } from '@angular/router';

import { AuthenticationService, BoardService } from "@app/services";
import { LoginPage } from "@app/pages/login/login.page";
import { FormsModule, NgForm } from "@angular/forms";
import { TranslateTestingModule } from "ngx-translate-testing";
import { TranslateService } from "@ngx-translate/core";
import { Account } from "@app/model";
import { Observable, of, scheduled } from "rxjs";
import { NotificationService } from "@app/services/notification.service";


describe('Login', () => {
  let component: LoginPage;
  let fixture: ComponentFixture<LoginPage>;
  let transService: TranslateService
  let authServiceSpy
  let routerSpy
  let notifySpy

  beforeEach(waitForAsync(() => {
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['login','getAccount','isAuthObs'])
    const boardServiceSpy = jasmine.createSpyObj('BoardService', ['getBoards'])
    routerSpy = {navigate: jasmine.createSpy('navigate')};
    notifySpy = jasmine.createSpyObj('NotificationService', ['msg', 'error'])

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
        {provide: BoardService, useValue: boardServiceSpy},
        {provide: Router, useValue: routerSpy},
        {provide: NotificationService, useValue: notifySpy},
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

    expect(authServiceSpy.isAuthObs).toHaveBeenCalledTimes(0)
  })

  it ('with valid url there is a login try', async () => {
    authServiceSpy.isAuthObs.and.returnValue(of(true))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    const form = component.form
    form.controls['url'].setValue("http://foo.bar")
    await component.onLogin(form)

    expect(authServiceSpy.isAuthObs).toHaveBeenCalledTimes(1)
    expect(authServiceSpy.login).toHaveBeenCalledTimes(1)

  })

  it ('with auth not possible there must be a notification with error', async () => {
    authServiceSpy.isAuthObs.and.returnValue(of(false))

    component = await fixture.componentInstance;
    await fixture.detectChanges();

    const form = component.form
    form.controls['url'].setValue("http://foo.bar")
    await component.onLogin(form)

    expect(authServiceSpy.isAuthObs).toHaveBeenCalledTimes(1)
    expect(authServiceSpy.login).toHaveBeenCalledTimes(1)
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
