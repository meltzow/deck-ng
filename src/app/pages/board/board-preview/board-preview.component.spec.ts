import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BoardPreviewComponent } from './board-preview.component';
import { HttpClientModule } from "@angular/common/http";
import { Board } from "@app/model/board";
import { StackService } from "@app/services";

describe('DashboardWidgetComponent', () => {
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
    component.board =  {id: 1}
    expect(component).toBeTruthy();
  });
});
