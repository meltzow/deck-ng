import { fakeAsync, TestBed, tick } from '@angular/core/testing';

import { AuthenticationService } from "@app/services/authentication.service";
import { CapacitorHttp } from "@capacitor/core";
import { Browser } from "@capacitor/browser";
import { LoginPollInfo, LoginCredentials, LoginService } from "@app/services/login.service";
import { HttpService } from "@app/services/http.service";
import { HttpResponse } from "@angular/common/http";

describe('LoginService', () => {
  let service: LoginService
  let authSpy
  let originalTimeout
  let httpSpy

  beforeEach(() => {
    originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL;
    // jasmine.DEFAULT_TIMEOUT_INTERVAL = 500000;
    authSpy = jasmine.createSpyObj('AuthenticationService', ['saveCredentials'])
    httpSpy = jasmine.createSpyObj('HttpService', ['post'])
    spyOn(window, 'open').and.callFake(function () {
      return window
    });

    TestBed.configureTestingModule({
      providers: [
        {provide: AuthenticationService, useValue: authSpy},
        {provide: HttpService, useValue: httpSpy},
      ]
    });
    service = TestBed.inject(LoginService);
  });

  afterEach(function () {
    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('simple login - everything is working perfect', async () => {

    const pollUrl = "http://foo.bar"
    const login1: LoginPollInfo = {
      poll: {
        token: "foobar",
        endpoint: "http://boo.far/endpoint"
      },
      login: "http://boo.far/login"
    }

    httpSpy.post.withArgs('/index.php/login/v2', null, {withCredentials: false} ).and.returnValue(Promise.resolve<LoginPollInfo>(login1))

    httpSpy.post.withArgs(login1.poll.endpoint, {token: login1.poll.token},{withCredentials: false} ).and.returnValue(
      Promise.resolve(new HttpResponse<LoginCredentials>({
      body: {
        server: "http://boo.far",
        loginName: "username",
        appPassword: "password"
      }, status: 200
    })))

    authSpy.saveCredentials.and.returnValue(Promise.resolve(true))

    const pendingRequest = await service.login(pollUrl)
    expect(pendingRequest).toBeTrue()
    expect(window.open).toHaveBeenCalledWith("http://boo.far/login", '_blank')
  })

  //not working see https://github.com/jasmine/jasmine/issues/1648
  xit('normal login - waiting 2times until auth', async () => {
    service.initialTimeoutInMs = 10
    service.incrementInMs = 200
    service.maxTimeoutInMS = 1000
    const serverUrl = "http://foo.bar"

    const login1: LoginPollInfo = {
      poll: {
        token: "foobar",
        endpoint: "http://boo.far/endpoint"
      },
      login: "http://boo.far/login"
    }
    const login2: LoginCredentials = {
      server: "http://boo.far",
      loginName: "username",
      appPassword: "password"
    }

    // httpSpy.post.withArgs('/index.php/login/v2', null, {withCredentials: false} ).and.returnValue(Promise.resolve<LoginPollInfo>(login1))

    httpSpy.post.and.returnValues(
      Promise.resolve<LoginPollInfo>(login1),
      Promise.reject(new HttpResponse<LoginCredentials>({
        status: 404
      })),
      Promise.reject(new HttpResponse<LoginCredentials>({
        status: 404
      })),
      // Promise.resolve(new HttpResponse<LoginCredentials>({
      //   status: 404
      // })),
      // Promise.resolve(new HttpResponse<LoginCredentials>({
      //   status: 404
      // })),
      Promise.resolve(new HttpResponse<LoginCredentials>({
        body: login2, status: 200
      })))

    authSpy.saveCredentials.and.returnValue(Promise.resolve(true))

    const pendingRequest = await service.login(serverUrl)
    expect(pendingRequest).toBeTrue()
    expect(httpSpy.post).toHaveBeenCalledTimes(4)
    expect(window.open).toHaveBeenCalledWith("http://boo.far/login", '_blank')
  })

  //not working see https://github.com/jasmine/jasmine/issues/1648
  xit('login not successfully - waiting too long', async () => {
    service.initialTimeoutInMs = 0
    service.incrementInMs = 200
    service.maxTimeoutInMS = 100
    const serverUrl = "http://foo.bar"

    const login1: LoginPollInfo = {
      poll: {
        token: "foobar",
        endpoint: "http://boo.far/endpoint"
      },
      login: "http://boo.far/login"
    }

    httpSpy.post.withArgs('/index.php/login/v2', null, {withCredentials: false} ).and.returnValue(Promise.resolve<LoginPollInfo>(login1))

    httpSpy.post.withArgs(login1.poll.endpoint, {token: login1.poll.token},{withCredentials: false} ).and.returnValues(Promise.resolve(new HttpResponse<LoginCredentials>({
        status: 404
      })),
      Promise.reject(new HttpResponse<LoginCredentials>({
        status: 404
      })),
      Promise.reject(new HttpResponse<LoginCredentials>({
        status: 404
      })),
      Promise.reject(new HttpResponse<LoginCredentials>({
        status: 404
      }))
    )

    await expectAsync(service.login(serverUrl)).toBeRejectedWith("Authentication hit the maximum timeout")
    expect(window.open).toHaveBeenCalledWith("http://boo.far/login", '_blank')
  })


  xit('normal login', async function () {
    // await service.ngOnInit()
    // expect(service.isAuthSubj().value).toBeFalse();
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
        } as LoginCredentials,
        status: 200
      }))

    const succ = await service.login("http://foo.bar")
    expect(succ).toBeTrue()
    // expect(service.isAuthSubj().value).toBeTrue()
    //
    // await service.logout()
    // expect(service.isAuthSubj().value).toBeFalse()

    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
  });
});
