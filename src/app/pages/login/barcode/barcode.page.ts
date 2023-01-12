import { Component, OnDestroy, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { BarcodeScanner, CameraDirection } from '@capacitor-community/barcode-scanner';
import { Platform } from "@ionic/angular";
import { NotificationService } from "@app/services/notification.service";

@Component({
  selector: 'app-barcode',
  templateUrl: './barcode.page.html'
})
export class BarcodePage implements OnInit, OnDestroy {
  barcode: barCodeItem
  private handlerMessage: string;

  constructor(
    public authenticationService: AuthenticationService,
    public router: Router,
    private platform: Platform,
    public notifcationService: NotificationService,
  ) { }

  ngOnDestroy(): void {
      if (!this.platform.is('desktop')) {
        this.stopScan()
      }
    }

  ngOnInit() {
    this.platform.backButton.subscribeWithPriority(10, () => {
      this.stopScan()
      this.router.navigate(['auth']);
    });
    if (!this.platform.is('desktop')) {
      this.onBarcode()
    }
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
        this.authenticationService.saveCredentials(this.barcode.url, this.barcode.user, this.barcode.password, true)
        this.stopScan()
      }
    } else {
        this.stopScan()
      this.router.navigate(['auth']);
    }
  }

  public parseContent(content: string) {
    const ary = content.split('&')
    this.barcode = {}
    this.barcode.user = ary[0].replace('nc://login/user:', '')
    this.barcode.password= ary[1].replace('password:','')
    this.barcode.url= ary[2].replace('server:','')

    if (!this.barcode.url || !this.barcode.user || !this.barcode.password ) {
      this.notifcationService.error("barcode must contain url, user and password")
    }

  }
  stopScan() {
    document.querySelector('body').classList.remove('scanner-active');
    BarcodeScanner.showBackground();
    BarcodeScanner.stopScan();
  }

}

interface barCodeItem {
  url?: string,
  password?: string,
  user?: string
}
