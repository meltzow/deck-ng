import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { BasicAuthInterceptor } from '@app/helper/basic.auth.interceptor';
import { ErrorInterceptor } from '@app/helper/error.interceptor';
import { IonicStorageModule } from "@ionic/storage";
import { FormsModule } from "@angular/forms";
import { ApiModule } from "@app/api.module";
import { Configuration, ConfigurationParameters } from "@app/configuration";
import { MyRenderer } from "@app/services";
import { environment } from "@environments/environment";


export function apiConfigFactory (): Configuration {
  const params: ConfigurationParameters = {
    // set configuration parameters here.
    // username: 'deckNG',
    // password: 'oqZGBIapTp2yltBYri6cfUKQQtCbxS2fMVzICTm4C1bV6ZMCEQo10ziCBnnEN35Oh4B9821S'
  }
  params.basePath = environment.deckApiUrl
  return new Configuration(params);
}

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule,  HttpClientModule, FormsModule,
    IonicModule.forRoot(),IonicStorageModule.forRoot(), AppRoutingModule, ApiModule.forRoot(apiConfigFactory),
  ],
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    { provide: HTTP_INTERCEPTORS, useClass: BasicAuthInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true },
    MyRenderer
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
