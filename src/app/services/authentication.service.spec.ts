import { TestBed } from '@angular/core/testing';

import { AuthenticationService } from "@app/services/authentication.service";
import { IonicStorageModule } from "@ionic/storage-angular";
import { Storage } from '@ionic/storage';
import { Router } from "@angular/router";
import { NotificationService } from "@app/services/notification.service";
import { CapacitorHttp } from "@capacitor/core";
import { Account } from "@app/model";
import { Browser } from "@capacitor/browser";

describe('AuthenticationService', () => {
  let service: AuthenticationService;
  let storage: Storage
  let routerSpy
  let noticationSpy

  beforeEach(() => {
    routerSpy = {navigate: jasmine.createSpy('navigate')};
    noticationSpy = jasmine.createSpyObj('NotificationService',['msg'])

    TestBed.configureTestingModule({
      imports:[IonicStorageModule.forRoot()],
      providers: [
        { provide: Router, useValue: routerSpy },
        { provide: NotificationService, useValue: noticationSpy },
      ]
    });
    service = TestBed.inject(AuthenticationService);
    storage = TestBed.inject(Storage)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('getAccount always delivers Promise', async function()  {
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

  it('test behavior', async function() {
    await service.ngOnInit()
    expect(service.isAuthSubj().value).toBeFalse();
    spyOn(CapacitorHttp, 'post');
    spyOn(Browser, 'open');

    (CapacitorHttp.post as any)
      // .withArgs({
      //   url: "http://localhost:8080" + '/index.php/login/v2',
      //   // headers: {
      //   //   'Accept': 'application/json',
      //   //   'Content-Type': 'application/json'
      //   // },
      // })
      .and.returnValue(Promise.resolve({
      data: { poll: {
          token: "foobar",
          endpoint: "http://foo.bar"
        }, login: "http://boo.far"
        },
      status: 200,
      // headers: HttpHeaders;
      // url: string;
    }))

    const succ = await service.login("http://localhost:8080")
    expect(succ).toBeTrue()
    expect(service.isAuthSubj().value).toBeTrue()

    await service.logout()
    expect(service.isAuthSubj().value).toBeFalse()
  });

  it('isAuth == false if there is no saved user', async function ()  {
    await service.ngOnInit()
    await service.logout()

    // expect(routerSpy.navigate).toHaveBeenCalledWith(['login']);

    await service.isAuthenticated()
      .then(value => expect(value).toBeFalse())
      .catch(() => fail())
  })

  it('isAuth == false if there is are credentials but not authenticated ', async function ()  {
    await service.ngOnInit()
    await service.logout()
    await service.saveCredentials("url", "username", "password")

    // expect(routerSpy.navigate).toHaveBeenCalledWith(['login']);

    await service.isAuthenticated()
      .then(value => expect(value).toBeFalse())
      .catch(reason => fail())
  })

  it('isAuthenticated is working', async function ()  {
    await service.ngOnInit()
    await service.logout()
    // expect (routerSpy.navigate).toHaveBeenCalledWith(['/login']);

    let auth: boolean = await service.isAuthenticated()

    expect(auth).toBeFalse()

    await service.login('http://foo.bar/')
    // expect (routerSpy.navigate).toHaveBeenCalledWith(['/home']);

    auth = await service.isAuthenticated()

    expect(auth).toBeTruthy()
  })

});
