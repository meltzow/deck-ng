import { Component, ContentChild } from '@angular/core';
import { IonInput } from "@ionic/angular";

@Component({
  selector: 'app-show-hide-password',
  templateUrl: './show-hide-password.component.html',
  styleUrls: ['./show-hide-password.component.scss'],
})
export class ShowHidePasswordComponent {
  showPassword = false;

  @ContentChild(IonInput) input: IonInput;

  toggleShow() {
    this.showPassword = !this.showPassword;
    this.input.type = this.showPassword ? 'text' : 'password';
  }
}
