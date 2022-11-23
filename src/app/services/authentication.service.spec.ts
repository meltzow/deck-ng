import { TestBed, waitForAsync } from '@angular/core/testing';

import { AuthenticationService } from "@app/services/authentication.service";
import { HttpClientTestingModule } from "@angular/common/http/testing";
import { IonicStorageModule } from "@ionic/storage-angular";
import { Storage } from '@ionic/storage';
import { Router } from "@angular/router";

describe('AuthenticationService', () => {
  let service: AuthenticationService;
  let storage: Storage
  let routerSpy

  beforeEach(() => {
    routerSpy = {navigate: jasmine.createSpy('navigate')};

    TestBed.configureTestingModule({
      imports:[IonicStorageModule.forRoot()],
      providers: [
        { provide: Router, useValue: routerSpy }
      ]
    });
    service = TestBed.inject(AuthenticationService);
    storage = TestBed.inject(Storage)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('test behavior', async function() {
    await service.ngOnInit()
    expect(service.isAuthSubj.value).toBeFalse()

    await service.login("https://foo.bar", "foo", "bar")
    expect(service.isAuthSubj.value).toBeTrue()

    await service.logout()
    expect(service.isAuthSubj.value).toBeFalse()
  });

  it('deliver error if there is no saved user', async function ()  {
    await service.ngOnInit()
    await service.logout()

    expect(routerSpy.navigate).toHaveBeenCalledWith(['login']);

    await service.getAccount()
      .then(value => fail('must not happend'))
      .catch(reason => expect(reason).toEqual('user not authenticated'))
  })

  it('isAuthenticated is working', async function ()  {
    await service.ngOnInit()
    await service.logout()
    // expect (routerSpy.navigate).toHaveBeenCalledWith(['/login']);

    let auth: boolean = await service.isAuthenticated()

    expect(auth).toBeFalse()

    await service.login('http://foo.bar/', 'bar', 'secret')
    // expect (routerSpy.navigate).toHaveBeenCalledWith(['/home']);

    auth = await service.isAuthenticated()

    expect(auth).toBeTruthy()
  })

});
