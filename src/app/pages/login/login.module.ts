import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';

import { LoginPage } from './login.page';
import { LoginPageRoutingModule } from './login-routing.module';
import { TranslateLoader, TranslateModule } from "@ngx-translate/core";
import { createTranslateLoader } from "@app/app.module";
import { HttpClient } from "@angular/common/http";
import { ShowHidePasswordComponent } from "@app/components/show-hide-password/show-hide-password.component";

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    LoginPageRoutingModule, TranslateModule.forChild({
      loader: {
        provide: TranslateLoader,
        useFactory: createTranslateLoader,
        deps: [HttpClient]
      }
    })
  ],
  declarations: [
    LoginPage,
    ShowHidePasswordComponent
  ]
})
export class LoginModule { }
