import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskPreviewComponent } from './task-preview.component';
import { HttpClientModule } from "@angular/common/http";
import { AuthenticationService } from "@app/services";
import { CardsService } from "@app/services/cards.service";

describe('TaskPreviewComponent', () => {
  let component: TaskPreviewComponent;
  let fixture: ComponentFixture<TaskPreviewComponent>;
  let cardServiceSpy

  beforeEach(async () => {

    cardServiceSpy = jasmine.createSpyObj('CardService',['getCard'])

    await TestBed.configureTestingModule({
      declarations: [ TaskPreviewComponent ],
      imports:[HttpClientModule],
      providers: [
        { provide: CardsService, useValue: cardServiceSpy },
      ]
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
