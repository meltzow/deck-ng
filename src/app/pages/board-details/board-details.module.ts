import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { BoardDetailsPage } from './board-details.page';

import { IonicModule } from '@ionic/angular';

import { CardPreviewComponent } from './card-preview/card-preview.component';
import { BoardDetailsPageRoutingModule } from "@app/pages/board-details/board-details-routing.module";
import { AppModule } from "@app/app.module";
import { SharedModule } from "@app/shared.module";

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    BoardDetailsPageRoutingModule,
    SharedModule,

  ],
    declarations: [BoardDetailsPage, CardPreviewComponent]
})
export class BoardDetailsModule {}
