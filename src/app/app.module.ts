import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouteReuseStrategy } from '@angular/router';

import { IonicModule, IonicRouteStrategy } from '@ionic/angular';

import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { HTTP_INTERCEPTORS, HttpClientModule, HttpClientXsrfModule } from '@angular/common/http';
import { ErrorInterceptor } from '@app/helper/error.interceptor';
import { IonicStorageModule } from '@ionic/storage-angular';
import { FormsModule } from "@angular/forms";
import { ApiModule } from "@app/api.module";
import { Configuration, ConfigurationParameters } from "@app/configuration";
import { MyRenderer } from "@app/services";
import { environment } from "@environments/environment";
import { AuthGuard } from "@app/helper/auth-guard";
import { MarkdownModule } from 'ngx-markdown';


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
  imports: [BrowserModule,  HttpClientModule, HttpClientXsrfModule.disable(), FormsModule,
    IonicModule.forRoot(),IonicStorageModule.forRoot(), AppRoutingModule, ApiModule.forRoot(apiConfigFactory),
    MarkdownModule.forRoot(),
  ],
  providers: [
    { provide: RouteReuseStrategy, useClass: IonicRouteStrategy },
    { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true },
    MyRenderer,
    AuthGuard
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
