import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ServerAdressPage } from './server-adress.page';

const routes: Routes = [
  {
    path: '',
    component: ServerAdressPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ServerAdressPageRoutingModule {}
