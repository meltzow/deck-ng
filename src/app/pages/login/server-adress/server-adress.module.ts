import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { ServerAdressPageRoutingModule } from './server-adress-routing.module';

import { ServerAdressPage } from './server-adress.page';
import { BarcodePage } from "@app/pages/login/server-adress/barcode.page";

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ServerAdressPageRoutingModule
  ],
  declarations: [ServerAdressPage, BarcodePage]
})
export class ServerAdressPageModule {}
