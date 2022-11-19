import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from "@app/services";
import { Router } from "@angular/router";
import { NgForm } from "@angular/forms";
import { Platform } from "@ionic/angular";

@Component({
  selector: 'app-url',
  templateUrl: './url.page.html',
  styleUrls: ['./url.page.scss'],
})
export class UrlPage implements OnInit {
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
