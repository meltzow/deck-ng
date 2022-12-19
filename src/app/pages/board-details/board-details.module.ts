import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { BoardDetailsPage } from './board-details.page';

import { IonicModule } from '@ionic/angular';

import { InlineEditComponent } from "@app/inline-edit/inline-edit.component";
import { CardPreviewComponent } from './card-preview/card-preview.component';
import { BoardDetailsPageRoutingModule } from "@app/pages/board-details/board-details-routing.module";

@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        IonicModule,
        BoardDetailsPageRoutingModule
    ],
    exports: [
        InlineEditComponent
    ],
    declarations: [BoardDetailsPage, InlineEditComponent, CardPreviewComponent]
})
export class BoardDetailsModule {}
