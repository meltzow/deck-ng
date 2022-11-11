import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AuthGuard } from "@app/helper/auth-guard";

const routes: Routes = [
  {
    path: 'home',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/board/board-overview.module').then( m => m.BoardOverviewPageModule)
  },
  {
    path: 'board/:id',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/view-board/view-board.module').then( m => m.ViewBoardModule)
  },
  {
    path: 'board/:boardId/stack/:stackId/card/:cardId',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/card/card.module').then( m => m.CardModule)
  },
  // {
  //   path: 'account',
  //   loadChildren: () => import('./account/account.module').then(m => m.AccountModule)
  // },
  // {
  //   path: 'support',
  //   loadChildren: () => import('./pages/support/support.module').then(m => m.SupportModule)
  // },
  {
    path: 'login',
    loadChildren: () => import('./pages/login/login.module').then(m => m.LoginModule)
  },
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full'
  },
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
