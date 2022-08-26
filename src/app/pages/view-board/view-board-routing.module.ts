import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ViewBoardPage } from './view-board.page';

const routes: Routes = [
  {
    path: '',
    component: ViewBoardPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ViewBoardPageRoutingModule {}
