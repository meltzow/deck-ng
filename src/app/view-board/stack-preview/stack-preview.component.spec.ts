import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StackPreviewComponent } from './stack-preview.component';

describe('StackPreviewComponent', () => {
  let component: StackPreviewComponent;
  let fixture: ComponentFixture<StackPreviewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StackPreviewComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(StackPreviewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
