import { Injectable } from '@angular/core';
import { Observable, from, firstValueFrom } from "rxjs";
import { Account, Attachement } from "@app/model";
import { AuthenticationService } from "@app/services/authentication.service";
import { HttpService } from "@app/services/http.service";


@Injectable({
  providedIn: 'root'
})
export class AttachmentService {

  constructor(
    private httpService: HttpService) {
  }

  public getAttachments(boardId: number, stackId: number, cardId: number): Promise<Attachement[]> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling updateCard.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling updateCard.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling updateCard.');
    }
    return this.httpService.get<Attachement[]>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}`)
  }
}
