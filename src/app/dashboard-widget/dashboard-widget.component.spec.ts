import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DashboardWidgetComponent } from './dashboard-widget.component';
import { HttpClientModule } from "@angular/common/http";
import { BoardItem } from "@app/model/boardItem";
import { StackService } from "@app/services";

describe('DashboardWidgetComponent', () => {
  let component: DashboardWidgetComponent;
  let fixture: ComponentFixture<DashboardWidgetComponent>;
  let stackServiceSpy

  beforeEach(async () => {

    stackServiceSpy = jasmine.createSpyObj('StackService',['getStacks'])

    await TestBed.configureTestingModule({
      imports: [HttpClientModule],
      declarations: [ DashboardWidgetComponent ],
      providers: [{ provide: StackService, useValue: stackServiceSpy }]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    component.board =  {id: 1}
    expect(component).toBeTruthy();
  });
});
