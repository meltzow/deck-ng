import { fakeAsync, TestBed, tick } from '@angular/core/testing';

import { AuthenticationService } from "@app/services/authentication.service";
import { IonicStorageModule } from "@ionic/storage-angular";
import { Storage } from '@ionic/storage';
import { Router } from "@angular/router";
import { NotificationService } from "@app/services/notification.service";
import { CapacitorHttp } from "@capacitor/core";
import { Account } from "@app/model";
import { Browser } from "@capacitor/browser";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";

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
