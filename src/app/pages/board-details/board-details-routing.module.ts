import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { BoardDetailsPage } from './board-details.page';

const routes: Routes = [
  {
    path: '',
    component: BoardDetailsPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BoardDetailsPageRoutingModule {}
