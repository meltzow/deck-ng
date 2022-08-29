import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CardComponent } from './card.component';
import { HttpClientTestingModule } from "@angular/common/http/testing";
import { CardsService } from "@app/services/cards.service";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { ActivatedRoute, convertToParamMap } from "@angular/router";
import { Observable, of } from "rxjs";
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
    const response = new Observable<Card>((observer) => {
      // observable execution
      observer.next(card);
      observer.complete();
    });

    cardServiceSpy.getCard.and.returnValue(response)

    fixture = TestBed.createComponent(CardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {


    expect(component).toBeTruthy();
  });
});