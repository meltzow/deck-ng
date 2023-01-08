import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AuthGuard } from "@app/helper/auth-guard";

const routes: Routes = [
  {
    path: 'boards',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/board/board-overview.module').then( m => m.BoardOverviewPageModule)
  },
  {
    path: 'boards/:id',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/board-details/board-details.module').then(m => m.BoardDetailsModule)
  },
  {
    path: 'boards/:boardId/stacks/:stackId/cards/:cardId',
    canActivate: [AuthGuard],
    loadChildren: () => import('./pages/card-details/card-details.module').then(m => m.CardDetailsModule)
  },
  {
    path: 'login',
    loadChildren: () => import('./pages/login/login.module').then(m => m.LoginModule)
  },
  {
    path: '',
    redirectTo: 'boards',
    pathMatch: 'full'
  },
  {
    path: 'home',
    redirectTo: 'boards',
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
