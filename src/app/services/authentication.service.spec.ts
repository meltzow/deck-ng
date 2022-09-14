import { TestBed, waitForAsync } from '@angular/core/testing';

import { AuthenticationService } from "@app/services/authentication.service";
import { HttpClientTestingModule } from "@angular/common/http/testing";
import { IonicStorageModule } from "@ionic/storage-angular";
import { Storage } from '@ionic/storage';

describe('AuthenticationService', () => {
  let service: AuthenticationService;
  let storage: Storage

  beforeEach(() => {

    TestBed.configureTestingModule({
      imports:[IonicStorageModule.forRoot()],
    });
    service = TestBed.inject(AuthenticationService);
    storage = TestBed.inject(Storage)
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('deliver error if there is no saved user', async function ()  {
    await service.ngOnInit()
    await service.logout()

    await service.getAccount()
      .then(value => fail('must not happend'))
      .catch(reason => expect(reason).toEqual('user not authenticated'))
  })
});
