import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { LoginPage } from './login.page';
import { BarcodePage } from "@app/pages/login/barcode/barcode.page";

const routes: Routes = [
  {
    path: '',
    component: LoginPage
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
