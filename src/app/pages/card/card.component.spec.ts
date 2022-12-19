import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CardComponent } from './card.component';
import { HttpClientTestingModule} from "@angular/common/http/testing";
import { CardsService } from "@app/services/cards.service";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { ActivatedRoute, convertToParamMap } from "@angular/router";
import { Label } from "@app/model";
import { AuthenticationService, BoardService } from "@app/services";

describe('CardComponent', () => {
  let component: CardComponent;
  let fixture: ComponentFixture<CardComponent>;
  let cardServiceSpy
  let boardServiceSpy
  let authServiceSpy

  beforeEach(async () => {
    cardServiceSpy = jasmine.createSpyObj('CardService', ['getCard', 'removeLabel2Card', 'assignLabel2Card'])
    boardServiceSpy = jasmine.createSpyObj('BoardService', ['getBoard'])
    authServiceSpy = jasmine.createSpyObj('AuthenticationService', ['login','getAccount','isAuthObs'])


    await TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [
        { provide: CardsService, useValue: cardServiceSpy },
        { provide: BoardService, useValue: boardServiceSpy },
        { provide: AuthenticationService, useValue: authServiceSpy},
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

  it('used labels are preselected', () => {
    const l1: Label = {id: 1, title: "foo"}
    const l2: Label = {id: 2, title: "foo"}
    const l3: Label = {id: 2, title: "foo"}
    component.card = {id: 1, title: "dddd"}
    component.card.labels = [l1]
    expect(component.labelPreselected(l3, l2)).toBeTruthy()
    expect(component.labelPreselected(l2, l1)).toBeFalse()
  });

  it('handlelabelChange remove not used labels and assign new ones', () => {
    const newLabel1: Label = {id: 1, title: "foo"}
    const newLabel2: Label = {id: 2, title: "foo"}
    const preselectedLabel: Label = {id: 3, title: "foo"}

    const event = new CustomEvent("ionChange", {detail: {value: [newLabel1, newLabel2]}})
    component.card = {id: 1, stackId: 1, title: "dddd"}
    component.card.labels = [preselectedLabel]
    component.handleLabelChange(event)

    expect(cardServiceSpy.assignLabel2Card).toHaveBeenCalledWith(1,1,1,1)
    expect(cardServiceSpy.assignLabel2Card).toHaveBeenCalledWith(1,1,1,2)
    expect(cardServiceSpy.removeLabel2Card).toHaveBeenCalledWith(1,1,1,3)
  });

});
