import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginPage } from './login.page';
import { UrlPage } from "@app/pages/login/url/url.page";
import { BarcodePage } from "@app/pages/login/barcode/barcode.page";

const routes: Routes = [
  {
    path: 'login',
    component: LoginPage
  },
  {
    path: '',
    component: UrlPage
  },
  {
    path: 'barcode',
    component: BarcodePage
  }
];
@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LoginPageRoutingModule { }
