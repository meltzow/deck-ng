import { TestBed } from '@angular/core/testing';

import { StackService } from './stack.service';
import {StackItem} from "@app/model";
import { HttpClientModule } from "@angular/common/http";
import { RouterModule } from "@angular/router";
// import jasmine from 'jasmine'
import 'jasmine-ajax'
import { fetch as fetchPolyfill } from 'whatwg-fetch';
import { BoardItem } from "@app/model/boardItem";

describe('StackService', () => {
  let service: StackService;
  let originalFetch;

  beforeEach(() => {
    originalFetch = (window as any).fetch;
    (window as any).fetch = fetchPolyfill;
    jasmine.Ajax.install();

    TestBed.configureTestingModule({
      imports: [RouterModule.forRoot([]), HttpClientModule],
    });
    service = TestBed.inject(StackService);
  });

  afterEach(() => {
    jasmine.Ajax.uninstall();
    (window as any).fetch = originalFetch;
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should handle failed stacks load', async () => {
    jasmine.Ajax.stubRequest(service.baseUrl(223)).andError({
      status: 404,
      statusText: 'HTTP/1.1 404 Not Found'
    });

    try {
      await service.getStacks(223)
      fail('Asset should fail to load.');
    } catch {
      expect('true').toBeTruthy()
    }
  });

  it('should load sboarditems', async () => {
    const board: BoardItem = {title: 'foo', id: 111}
    const stack:StackItem = {title: "todo"}
    const respValues = [stack];
    jasmine.Ajax.stubRequest(service.baseUrl(board.id)).andReturn({
      responseJSON: respValues
    });

    const response = await service.getStacks(board.id);
    expect(response[0].title).toBe('todo');
  });

});
