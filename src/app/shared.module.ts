import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InlineEditComponent } from "@app/inline-edit/inline-edit.component";



@NgModule({
  declarations: [InlineEditComponent],
  imports: [
    CommonModule
  ],
  exports: [
    InlineEditComponent
  ]
})
export class SharedModule { }
