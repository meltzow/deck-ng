import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskPreviewComponent } from './task-preview.component';
import { HttpClientModule } from "@angular/common/http";

describe('TaskPreviewComponent', () => {
  let component: TaskPreviewComponent;
  let fixture: ComponentFixture<TaskPreviewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TaskPreviewComponent ],
      imports:[HttpClientModule]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TaskPreviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
