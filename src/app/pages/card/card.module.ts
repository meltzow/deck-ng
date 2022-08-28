import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CardComponent } from './card.component';
import { IonicModule } from "@ionic/angular";
import { CardPageRoutingModule } from "@app/pages/card/card-routing.module";
import { MarkdownModule } from "ngx-markdown";
import { FormsModule } from "@angular/forms";


@NgModule({
  declarations: [
    CardComponent
  ],
  imports: [
    CommonModule,
    IonicModule,
    CardPageRoutingModule,
    MarkdownModule,
    FormsModule
  ],
})
export class CardModule { }
