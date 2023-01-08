import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardDetailsPage } from './card-details.page';
import { IonicModule } from "@ionic/angular";
import { CardDetailPageRoutingModule } from "@app/pages/card-details/card-details-page-routing.module";
import { FormsModule } from "@angular/forms";
import { AppModule } from "@app/app.module";
import { SharedModule } from "@app/shared.module";


@NgModule({
  declarations: [
    CardDetailsPage
  ],
  imports: [
    CommonModule,
    IonicModule,
    CardDetailPageRoutingModule,
    FormsModule,
    AppModule,
    SharedModule,
  ],
})
export class CardDetailsModule { }
