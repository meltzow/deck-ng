import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardComponent } from './card.component';
import { IonicModule } from "@ionic/angular";
import { CardPageRoutingModule } from "@app/pages/card/card-routing.module";


@NgModule({
  declarations: [
    CardComponent
  ],
  imports: [
    CommonModule,
    IonicModule,
    CardPageRoutingModule
  ],
})
export class CardModule { }
