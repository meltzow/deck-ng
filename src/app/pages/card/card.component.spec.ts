import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CardComponent } from './card.component';
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { CardsService } from "@app/services/cards.service";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { ActivatedRoute, convertToParamMap } from "@angular/router";
import { Observable } from "rxjs";
import { Card } from "@app/model/card";
import { MarkdownModule, MarkdownService } from "ngx-markdown";

describe('CardComponent', () => {
  let component: CardComponent;
  let fixture: ComponentFixture<CardComponent>;
  let cardServiceSpy
  let markdownServiceSpy

  beforeEach(async () => {
    cardServiceSpy = jasmine.createSpyObj('CardService', ['getCard'])
    markdownServiceSpy = jasmine.createSpyObj('MarkdownService', ['parse'])

    await TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, MarkdownModule],
      providers: [
        { provide: MarkdownService, useValue: markdownServiceSpy },
        { provide: CardsService, useValue: cardServiceSpy },
        { provide: ServiceHelper},
        {
          provide: ActivatedRoute,
          useValue: {
            snapshot: {
              paramMap: convertToParamMap({
                boardId: '1',
                stackId: '1',
                cardId: '1'
              })
            }
          }
        }
      ],
      declarations: [ CardComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    const card = {title: "this is the title"}

    cardServiceSpy.getCard.and.returnValue(Promise.resolve(card))

    fixture = TestBed.createComponent(CardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
