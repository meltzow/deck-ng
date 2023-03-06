import { TestBed } from '@angular/core/testing';

import { AttachmentService } from './attachment.service';

describe('AttachmentService', () => {
  let service: AttachmentService;
  let attachmentServiceSpy

  beforeEach(() => {
    attachmentServiceSpy = jasmine.createSpyObj('AttachmentService',['getAttachments'])
    TestBed.configureTestingModule({
      providers: [
        { provide: AttachmentService, useValue: attachmentServiceSpy },
      ]
    });
    service = TestBed.inject(AttachmentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
