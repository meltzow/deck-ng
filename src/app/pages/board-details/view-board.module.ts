import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { BoardDetailsPage } from './board-details.page';

import { IonicModule } from '@ionic/angular';

import { ViewBoardPageRoutingModule } from './view-board-routing.module';
import { InlineEditComponent } from "@app/inline-edit/inline-edit.component";
import { CardPreviewComponent } from './card-preview/card-preview.component';

@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        IonicModule,
        ViewBoardPageRoutingModule
    ],
    exports: [
        InlineEditComponent
    ],
    declarations: [BoardDetailsPage, InlineEditComponent, CardPreviewComponent]
})
export class ViewBoardModule {}
