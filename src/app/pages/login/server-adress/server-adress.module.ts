import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { ServerAdressPageRoutingModule } from './server-adress-routing.module';

import { ServerAdressPage } from './server-adress.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    ServerAdressPageRoutingModule
  ],
  declarations: [ServerAdressPage]
})
export class ServerAdressPageModule {}
