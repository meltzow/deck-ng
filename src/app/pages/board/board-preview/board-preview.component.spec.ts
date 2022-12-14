import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BoardPreviewComponent } from './board-preview.component';
import { HttpClientModule } from "@angular/common/http";
import { Board } from "@app/model/board";
import { StackService } from "@app/services";
import { Card } from "@app/model";

describe('BoardPreviewComponent', () => {
  let component: BoardPreviewComponent;
  let fixture: ComponentFixture<BoardPreviewComponent>;
  let stackServiceSpy

  beforeEach(async () => {

    stackServiceSpy = jasmine.createSpyObj('StackService',['getStacks'])

    await TestBed.configureTestingModule({
      imports: [HttpClientModule],
      declarations: [ BoardPreviewComponent ],
      providers: [{ provide: StackService, useValue: stackServiceSpy }]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BoardPreviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    component.board =  {id: 1, title: "foo"}
    expect(component).toBeTruthy();
  });

  it ('compute the sum of all cards in a board', async () => {
    component.stacks.next([
      {title: 'todo', boardId: 1, cards: [new Card(),new Card()]},
      {title: 'inprogress', boardId: 1, cards: [new Card()]},
      {title: 'no Cards', boardId: 1},
      {title: 'wrong boardId', boardId: 2, cards : [new Card()]},
    ])
    component.board = new Board(1)
    const sum = await component.getCardCount()
    expect(sum).toEqual(3)

  })
});
