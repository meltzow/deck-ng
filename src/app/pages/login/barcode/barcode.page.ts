import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { BarcodeScanner, CameraDirection } from '@capacitor-community/barcode-scanner';
import { Platform, ToastController } from "@ionic/angular";

@Component({
  selector: 'app-barcode',
  template: '<ion-content fullscreen="true" ></ion-content>'
})
export class BarcodePage implements OnInit {
  barcode: barCodeItem
  private handlerMessage: string;

  constructor(
    public authenticationService: AuthenticationService,
    public router: Router,
    private platform: Platform,
    public toastController: ToastController,
  ) { }

  ngOnInit() {
    this.platform.backButton.subscribeWithPriority(10, () => {
      this.stopScan()
      this.router.navigate(['login']);
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

    const c = confirm('Please scan a nextcloud login barcode.');
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
    } else {
        this.stopScan()
        this.router.navigate(['login']);
    }
  }

  public parseContent(content: string) {
    console.log(content); // log the raw scanned content

    const ary = content.split('&')
    this.barcode = {}
    this.barcode.user = ary[0].replace('nc://login/user:', '')
    this.barcode.password= ary[1].replace('password:','')
    this.barcode.url= ary[2].replace('server:','')

    if (!this.barcode.url || !this.barcode.user || !this.barcode.password ) {
      this.presentToastWithOptions("barcode must contain url, user and password")
    }

  }

  private stopScan() {
    document.querySelector('body').classList.remove('scanner-active');
    BarcodeScanner.showBackground();
    BarcodeScanner.stopScan();
  }

  async presentToastWithOptions(errorMsg: string, header?: string) {
    const toast = await this.toastController.create({
      header: header? header : 'Toast header',
      message: errorMsg,
      duration: 3000,
      icon: 'information-circle',
      position: 'bottom',
      buttons: [
        {
          text: 'More Info',
          role: 'info',
          handler: () => {
            this.handlerMessage = 'More Info clicked';
          }
        },
        {
          text: 'Dismiss',
          role: 'cancel',
          handler: () => {
            this.handlerMessage = 'Dismiss clicked';
          }
        }
      ]
    });
    await toast.present();
  }
}

interface barCodeItem {
  url?: string,
  password?: string,
  user?: string
}
