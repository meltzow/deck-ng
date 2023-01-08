import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InlineEditComponent } from "@app/inline-edit/inline-edit.component";
import { FormsModule } from "@angular/forms";
import { IonicModule } from "@ionic/angular";

@NgModule({
  declarations: [InlineEditComponent],
  imports: [
    CommonModule, FormsModule
  ],
  exports: [
    InlineEditComponent
  ]
})
export class SharedModule { }
