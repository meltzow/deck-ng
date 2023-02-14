import { Injectable } from '@angular/core';
import { Stack } from "@app/model";
import { HttpService } from "@app/services/http.service";

@Injectable({
  providedIn: 'root'
})
export class StackService {

  constructor(protected httpService: HttpService) {
  }

  public getStacks(boardId: number): Promise<Stack[]> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling getStacks.')
    }
    return this.httpService.get<Stack[]>(`/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}/stacks`)
  }
}
