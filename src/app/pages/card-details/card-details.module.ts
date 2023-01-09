import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardDetailsPage } from './card-details.page';
import { IonicModule } from "@ionic/angular";
import { CardDetailPageRoutingModule } from "@app/pages/card-details/card-details-page-routing.module";
import { FormsModule } from "@angular/forms";
import { SharedModule } from "@app/shared.module";
import { TranslateModule } from "@ngx-translate/core";


@NgModule({
  declarations: [
    CardDetailsPage
  ],
    imports: [
        CommonModule,
        IonicModule,
        CardDetailPageRoutingModule,
        FormsModule,
        SharedModule,
        TranslateModule,
    ],
})
export class CardDetailsModule { }
