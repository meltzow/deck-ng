import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { BoardOverviewPage } from "@app/pages/board/board-overview.page";

const routes: Routes = [
  {
    path: '',
    component: BoardOverviewPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class BoardPageRoutingModule {}
