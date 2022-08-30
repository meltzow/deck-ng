import { TestBed } from '@angular/core/testing';

import { AttachmentService } from './attachment.service';
import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper";

describe('AttachmentService', () => {
  let service: AttachmentService;
  let attachmentServiceSpy

  beforeEach(() => {
    attachmentServiceSpy = jasmine.createSpyObj('AttachmentService',['getAttachments'])
    TestBed.configureTestingModule({
      providers: [
        { provide: AttachmentService, useValue: attachmentServiceSpy },
        { provide: ServiceHelper}
      ]
    });
    service = TestBed.inject(AttachmentService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
