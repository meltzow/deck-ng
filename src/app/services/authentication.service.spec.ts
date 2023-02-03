import { fakeAsync, TestBed, tick } from '@angular/core/testing';

import { AuthenticationService, Login2 } from "@app/services/authentication.service";
import { IonicStorageModule } from "@ionic/storage-angular";
import { Storage } from '@ionic/storage';
import { Router } from "@angular/router";
import { NotificationService } from "@app/services/notification.service";
import { CapacitorHttp } from "@capacitor/core";
import { Account } from "@app/model";
import { Browser } from "@capacitor/browser";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { HttpErrorResponse, HttpEventType, HttpHeaderResponse } from "@angular/common/http";

describe('AuthenticationService', () => {
  let service: AuthenticationService;
  let storage: Storage
  let routerSpy
  let notificationSpy
  let originalTimeout
  let httpMock: HttpTestingController

  beforeEach(() => {
    originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL;
    // jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000;
    routerSpy = {navigate: jasmine.createSpy('navigate')};
    notificationSpy = jasmine.createSpyObj('NotificationService', ['msg'])

    TestBed.configureTestingModule({
      imports: [IonicStorageModule.forRoot(), HttpClientTestingModule],
      providers: [
        {provide: Router, useValue: routerSpy},
        {provide: NotificationService, useValue: notificationSpy},
      ]
    });
    service = TestBed.inject(AuthenticationService);
    storage = TestBed.inject(Storage)
    httpMock = TestBed.inject(HttpTestingController)
  });

  afterEach(function () {
    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('getAccount always delivers Promise', async function () {
    await service.ngOnInit()
    await storage.remove(AuthenticationService.KEY_USER)

    let r = await service.getAccount()
    expect(r).toBeNull()

    const a = new Account()
    a.isAuthenticated = false
    a.url = "https://foo.bar"
    await storage.set(AuthenticationService.KEY_USER, a)
    r = await service.getAccount()
    expect(r.url).toEqual(a.url)
  })

  it('try polling2', fakeAsync(() => {

    const pollUrl = "http://boo.far"
    const token = "foobar"
    const period = 20
    const count = 2

    const pendingRequest = service.accessPolling(pollUrl, token, period, count)

    // setTimeout(() => {
    const req1 = httpMock.expectOne(pollUrl)
    req1.flush({}, {
      status: 404
    })

    tick(period)
    const req2 = httpMock.expectOne(pollUrl)
    req2.flush({
      server: 'foobar',
      loginName: 'user1',
      appPassword: 'appPasswd'
    } as Login2, {
      status: 200,
      statusText: "success"
    })

    // expect(pendingRequest.appPassword).toEqual('appPasswd');
    httpMock.verify();

  }))

  it('try polling', async () => {

    const pollUrl = "http://boo.far"
    const token = "foobar"
    const period = 100
    const count = 2

    const pendingRequest = service.accessPolling(pollUrl, token, period, count)

    // Wait for the request to arrive
    const INTERVAL = period; // ms
    while ((httpMock as any).open.length === 0) {
      await new Promise((resolve) => setTimeout(resolve, INTERVAL));
    }
    // setTimeout(() => {
    // const reqs = httpMock.match(pollUrl)
    const req1 = httpMock.expectOne(pollUrl)
    req1.flush({}, {
      status: 404, statusText: "not found"
    })

    while ((httpMock as any).open.length === 0) {
      await new Promise((resolve) => setTimeout(resolve, INTERVAL));
    }
    const req2 = httpMock.expectOne(pollUrl)
    req2.flush({
      server: 'foobar',
      loginName: 'user1',
      appPassword: 'appPasswd'
    } as Login2, {
      status: 200,
      statusText: "success"
    })


    httpMock.verify();
    // })

    const response = await pendingRequest;
    expect(response.appPassword).toEqual('appPasswd')

  })

  xit('normal login', async function () {
    await service.ngOnInit()
    expect(service.isAuthSubj().value).toBeFalse();
    spyOn(CapacitorHttp, 'post');
    spyOn(Browser, 'open');
    //we are waiting 2secs for successful browser auth


    //mock first request
    (CapacitorHttp.post as any)
      .withArgs(({
        url: 'http://foo.bar/index.php/login/v2',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      } as any))
      .and.returnValue(Promise.resolve({
      data: {
        poll: {
          token: "foobar",
          endpoint: "http://foo.bar"
        }, login: "http://boo.far"
      },
      status: 200
    }));
    //mock second request
    (CapacitorHttp.post as any)
      .withArgs(({
        url: "http://foo.bar",
        params: {token: "foobar"},
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      } as any))
      .and.returnValues(
      Promise.resolve({
        status: 404
      }),
      Promise.resolve({
        status: 404
      }),
      Promise.resolve({
        data: {
          server: 'foobar',
          loginName: 'user1',
          appPassword: 'appPasswd'
        } as Login2,
        status: 200
      }))

    const succ = await service.login("http://foo.bar")
    expect(succ).toBeTrue()
    expect(service.isAuthSubj().value).toBeTrue()

    await service.logout()
    expect(service.isAuthSubj().value).toBeFalse()

    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
  });

  it('isAuth == false if there is no saved user', async function () {
    await service.ngOnInit()
    await service.logout()

    // expect(routerSpy.navigate).toHaveBeenCalledWith(['auth']);

    await service.isAuthenticated()
      .then(value => expect(value).toBeFalse())
      .catch(() => fail())
  })

  it('isAuth == false if there is are credentials but not authenticated ', async function () {
    await service.ngOnInit()
    await service.logout()
    await service.saveCredentials("url", "username", "password")

    // expect(routerSpy.navigate).toHaveBeenCalledWith(['auth']);

    await service.isAuthenticated()
      .then(value => expect(value).toBeFalse())
      .catch(reason => fail())
  })


});
