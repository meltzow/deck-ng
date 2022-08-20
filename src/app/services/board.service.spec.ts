import { TestBed } from '@angular/core/testing';

import { BoardService } from './board.service';
import {BoardItem} from "@app/model/boardItem";
import { HttpClientModule } from "@angular/common/http";
import { RouterModule } from "@angular/router";
// import jasmine from 'jasmine'
import 'jasmine-ajax'
import { fetch as fetchPolyfill } from 'whatwg-fetch';

describe('BoardService', () => {
  let service: BoardService;
  let originalFetch;

  beforeEach(() => {
    originalFetch = (window as any).fetch;
    (window as any).fetch = fetchPolyfill;
    jasmine.Ajax.install();

    TestBed.configureTestingModule({
      imports: [RouterModule.forRoot([]), HttpClientModule],
    });
    service = TestBed.inject(BoardService);
  });

  afterEach(() => {
    jasmine.Ajax.uninstall();
    (window as any).fetch = originalFetch;
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should handle failed boarditems load', async () => {
    jasmine.Ajax.stubRequest(service.baseUrl).andError({
      status: 404,
      statusText: 'HTTP/1.1 404 Not Found'
    });

    try {
      await service.boards()
      fail('Asset should fail to load.');
    } catch {
      expect('true').toBeTruthy()
    }
  });

  it('should load boarditems', async () => {
    const board:BoardItem = {title: "foo"}
    const formFieldValues = [board];
    jasmine.Ajax.stubRequest(service.baseUrl).andReturn({
      responseJSON: formFieldValues
    });

    const response = await service.boards();
    expect(response[0].title).toBe('foo');
  });

  it('should load a single boarditem', async () => {
    const board:BoardItem = {title: "foo", id: 1}
    jasmine.Ajax.stubRequest(service.baseUrl + '/' + board.id).andReturn({
      responseJSON: board
    });

    const response = await service.getBoard(board.id);
    expect(response.title).toBe('foo');
  });
});
