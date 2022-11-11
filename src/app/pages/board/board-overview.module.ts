import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IonicModule } from '@ionic/angular';
import { FormsModule } from '@angular/forms';

import { DashboardWidgetComponent } from "@app/dashboard-widget/dashboard-widget.component";
import { TranslateModule } from "@ngx-translate/core";
import { BoardOverviewPage } from "@app/pages/board/board-overview.page";
import { BoardPageRoutingModule } from "@app/pages/board/board-routing.module";

@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        IonicModule,
        BoardPageRoutingModule,
        TranslateModule
    ],
    declarations: [BoardOverviewPage, DashboardWidgetComponent]
})
export class BoardOverviewPageModule {}