import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BoardCardComponent } from './board-card.component';
import { HttpClientModule } from "@angular/common/http";
import { Board } from "@app/model/board";
import { StackService } from "@app/services";

describe('DashboardWidgetComponent', () => {
  let component: BoardCardComponent;
  let fixture: ComponentFixture<BoardCardComponent>;
  let stackServiceSpy

  beforeEach(async () => {

    stackServiceSpy = jasmine.createSpyObj('StackService',['getStacks'])

    await TestBed.configureTestingModule({
      imports: [HttpClientModule],
      declarations: [ BoardCardComponent ],
      providers: [{ provide: StackService, useValue: stackServiceSpy }]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BoardCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    component.board =  {id: 1}
    expect(component).toBeTruthy();
  });
});
