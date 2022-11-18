import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { BarcodeScanner, CameraDirection } from '@capacitor-community/barcode-scanner';
import { Platform } from "@ionic/angular";

@Component({
  selector: 'app-barcode',
  template: ''
})
export class BarcodePage implements OnInit {
  barcode: barCodeItem = {url: ''}

  constructor(
    public authenticationService: AuthenticationService,
    public router: Router,
    private platform: Platform
  ) { }

  ngOnInit() {
    this.platform.backButton.subscribeWithPriority(10, () => {
      this.stopScan()
      this.router.navigate(['login/barcode']);
    });
    this.onBarcode()
  }

  async onBarcode() {
    // this.submitted = true;
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
        this.parseContent(result.content)
        this.authenticationService.login(this.barcode.url, this.barcode.user, this.barcode.password)
        this.stopScan()
      }
    }
  }

  public parseContent(content: string) {
    console.log(content); // log the raw scanned content

    const ary = content.split('&')
    this.barcode.user = ary[0].replace('nc://login/user:', '')
    this.barcode.password= ary[1].replace('password:','')
    this.barcode.url= ary[2].replace('server:','')
  }

  private stopScan() {
    document.querySelector('body').classList.remove('scanner-active');
    BarcodeScanner.showBackground();
    BarcodeScanner.stopScan();
  }
}

interface barCodeItem {
  url: string,
  password?: string,
  user?: string
}
