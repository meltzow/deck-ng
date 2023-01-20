import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { BoardDetailsPage } from './board-details.page';
import { IonicModule } from '@ionic/angular';
import { CardPreviewComponent } from './card-preview/card-preview.component';
import { BoardDetailsPageRoutingModule } from "@app/pages/board-details/board-details-routing.module";
import { SharedModule } from "@app/shared.module";
import { SwiperModule } from "swiper/angular";

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    BoardDetailsPageRoutingModule,
    SharedModule,
    SwiperModule,
  ],
    declarations: [BoardDetailsPage, CardPreviewComponent]
})
export class BoardDetailsModule {}
