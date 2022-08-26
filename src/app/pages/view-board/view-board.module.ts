import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ViewBoardPage } from './view-board.page';

import { IonicModule } from '@ionic/angular';

import { ViewBoardPageRoutingModule } from './view-board-routing.module';
import { InlineEditComponent } from "@app/inline-edit/inline-edit.component";
import { TaskPreviewComponent } from './task-preview/task-preview.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ViewBoardPageRoutingModule
  ],
  declarations: [ViewBoardPage, InlineEditComponent, TaskPreviewComponent]
})
export class ViewBoardModule {}
