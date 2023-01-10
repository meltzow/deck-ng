import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CardPreviewComponent } from './card-preview.component';
import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService } from "@app/services";
import { CardsService } from "@app/services/cards.service";

describe('CardPreviewComponent', () => {
  let component: CardPreviewComponent;
  let fixture: ComponentFixture<CardPreviewComponent>;
  let cardServiceSpy

  beforeEach(async () => {

    cardServiceSpy = jasmine.createSpyObj('CardService',['getCard'])

    await TestBed.configureTestingModule({
      declarations: [ CardPreviewComponent ],
      imports:[HttpClientModule],
      providers: [
        { provide: CardsService, useValue: cardServiceSpy },
      ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CardPreviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
