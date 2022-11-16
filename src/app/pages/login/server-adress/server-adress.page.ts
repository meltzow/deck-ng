import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { BarcodeScanner, CameraDirection } from '@capacitor-community/barcode-scanner';
import { NgForm } from "@angular/forms";

@Component({
  selector: 'app-server-adress',
  templateUrl: './server-adress.page.html',
  styleUrls: ['./server-adress.page.scss'],
})
export class ServerAdressPage implements OnInit {
  login = { url:'' };
  submitted: false;


  constructor(
    public authenticationService: AuthenticationService,
    public router: Router
  ) { }

  ngOnInit() {
  }

  async onBarcode(loginForm: NgForm) {


    const status = await BarcodeScanner.checkPermission();

    if (status.denied) {
      // the user denied permission for good
      // redirect user to app settings if they want to grant it anyway
      const c = confirm('If you want to grant permission for using your camera, enable it in the app settings.');
      if (c) {
        BarcodeScanner.openAppSettings();
      }
    }


    // Check camera permission
    // This is just a simple example, check out the better checks below
    await BarcodeScanner.checkPermission({force: true});

    await BarcodeScanner.prepare();

    const c = confirm('Do you want to scan a barcode?');
    if (c) {
      document.querySelector('body').classList.add('scanner-active');
      // make background of WebView transparent
      // note: if you are using ionic this might not be enough, check below
      BarcodeScanner.hideBackground();
      const result = await BarcodeScanner.startScan({cameraDirection: CameraDirection.FRONT}); // start scanning and wait for a result

      // if the result has content
      if (result.hasContent) {
        console.log(result.content); // log the raw scanned content
      }
      const ary = result.content.split('&')
      console.log("NC:" , ary[0])
      console.log("SERVER:" , ary[1])
    }
    document.querySelector('body').classList.remove('scanner-active');
    BarcodeScanner.showBackground();
    BarcodeScanner.stopScan();
  }
}
