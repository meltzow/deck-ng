import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ServerAdressPage } from './server-adress.page';
import { BarcodePage } from "@app/pages/login/server-adress/barcode.page";

const routes: Routes = [
  {
    path: '',
    component: ServerAdressPage
  },
  {
    path: 'barcode',
    component: BarcodePage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ServerAdressPageRoutingModule {}
