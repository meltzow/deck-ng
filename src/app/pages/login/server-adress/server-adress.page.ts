import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { BarcodeScanner, CameraDirection } from '@capacitor-community/barcode-scanner';
import { NgForm } from "@angular/forms";
import { Platform } from "@ionic/angular";

@Component({
  selector: 'app-server-adress',
  templateUrl: './server-adress.page.html',
  styleUrls: ['./server-adress.page.scss'],
})
export class ServerAdressPage implements OnInit {
  barcode: barCodeItem = {url: ''}
  url: string
  submitted = false;

  constructor(
    public authenticationService: AuthenticationService,
    public router: Router,
    private platform: Platform
  ) { }

  ngOnInit() {
  }

  nextStep(form: NgForm) {
    this.submitted = true;

    if (form.valid) {
      this.router.navigate(['login/login'])
    }
  }


  onBarcode() {
    this.router.navigate(['login/barcode'])
  }
}

interface barCodeItem {
  url: string
}
