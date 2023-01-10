import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { TestBed, waitForAsync } from '@angular/core/testing';

import { AppComponent } from './app.component';
import { IonicModule } from "@ionic/angular";
import { RouterModule } from "@angular/router";
import { AuthenticationService } from "@app/services";
import { IonicStorageModule } from "@ionic/storage-angular";
import { TranslateLoader, TranslateModule } from "@ngx-translate/core";
import { HttpClient, HttpClientModule } from "@angular/common/http";
import { createTranslateLoader } from "@app/app.module";

describe('AppComponent', () => {

  beforeEach(waitForAsync(() => {

    const boardServiceSpy = jasmine.createSpyObj('AuthenticationService',['isAuthenticated'])
    boardServiceSpy.isAuthenticated.and.returnValue(true)

    TestBed.configureTestingModule({
      declarations: [AppComponent],
      schemas: [CUSTOM_ELEMENTS_SCHEMA],
      imports: [IonicModule.forRoot(), RouterModule.forRoot([]), IonicStorageModule.forRoot(),HttpClientModule, TranslateModule.forRoot({
        loader: {
          provide: TranslateLoader,
          useFactory: (createTranslateLoader),
          deps: [HttpClient]
        }
      })],
      providers: [{ provide: AuthenticationService, useValue: boardServiceSpy }],
    }).compileComponents();
  }));

  it('should create the app', () => {
    const fixture = TestBed.createComponent(AppComponent);
    const app = fixture.debugElement.componentInstance;
    expect(app).toBeTruthy();
  });

});
