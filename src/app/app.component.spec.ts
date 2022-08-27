import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { TestBed, waitForAsync } from '@angular/core/testing';

import { AppComponent } from './app.component';
import { IonicModule } from "@ionic/angular";
import { RouterModule } from "@angular/router";
import { IonicStorageModule } from "@ionic/storage";
import { AuthenticationService } from "@app/services";

describe('AppComponent', () => {

  beforeEach(waitForAsync(() => {

    const boardServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])
    boardServiceSpy.isAuthenticated.and.returnValue(true)

    TestBed.configureTestingModule({
      declarations: [AppComponent],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), IonicStorageModule.forRoot()],
      providers: [{ provide: AuthenticationService, useValue: boardServiceSpy }],
    }).compileComponents();
  }));

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app).toBeTruthy();
  });
  // TODO: add more tests!

});
