import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardComponent } from './card.component';
import { IonicModule } from "@ionic/angular";
import { CardPageRoutingModule } from "@app/pages/card/card-routing.module";
import { FormsModule } from "@angular/forms";
import { BoardDetailsModule } from "@app/pages/board-details/board-details.module";


@NgModule({
  declarations: [
    CardComponent
  ],
  imports: [
    CommonModule,
    IonicModule,
    CardPageRoutingModule,
    FormsModule,
    BoardDetailsModule
  ],
})
export class CardModule { }
