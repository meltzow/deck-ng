import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { RouterModule } from '@angular/router';
import { ViewBoardPageRoutingModule } from './view-board-routing.module';

import { ViewBoardPage } from './view-board.page';
import { HttpClientModule } from "@angular/common/http";

describe('ViewBoardPage', () => {
  let component: ViewBoardPage;
  let fixture: ComponentFixture<ViewBoardPage>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ViewBoardPage ],
      imports: [IonicModule.forRoot(), ViewBoardPageRoutingModule, RouterModule.forRoot([]), HttpClientModule],
    }).compileComponents();

    fixture = TestBed.createComponent(ViewBoardPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
