import { LOCALE_ID, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { HTTP_INTERCEPTORS, HttpClient, HttpClientModule, HttpClientXsrfModule } from '@angular/common/http';
import { ErrorInterceptor } from '@app/helper/error.interceptor';
import { IonicStorageModule } from '@ionic/storage-angular';
import { FormsModule } from "@angular/forms";
import { MyRenderer } from "@app/services";
import { AuthGuard } from "@app/helper/auth-guard";
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';
import { NotificationService } from "@app/services/notification.service";
import { registerLocaleData } from '@angular/common';
import localeDe from '@angular/common/locales/de';
import { SharedModule } from "@app/shared.module";
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
registerLocaleData(localeDe);

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, HttpClientModule, HttpClientXsrfModule.disable(), FormsModule,
    IonicModule.forRoot(), IonicStorageModule.forRoot(), AppRoutingModule, SharedModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (createTranslateLoader),
        deps: [HttpClient]
      }
    }),
    BrowserAnimationsModule
  ],
  providers: [
    {provide: RouteReuseStrategy, useClass: IonicRouteStrategy},
    // {provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true},
    {provide: LOCALE_ID, useValue: navigator.language},
    MyRenderer,
    AuthGuard,
    NotificationService
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}


export function createTranslateLoader(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}
