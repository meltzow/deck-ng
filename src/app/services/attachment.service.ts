import { Injectable } from '@angular/core';
import { Observable, from, firstValueFrom } from "rxjs";
import { Attachement } from "@app/model";
import { ServiceHelper } from "@app/helper/serviceHelper";
import { AuthenticationService } from "@app/services/authentication.service";
import { HttpClient } from "@angular/common/http";


@Injectable({
  providedIn: 'root'
})
export class AttachmentService {

  constructor(
    private serviceHelper: ServiceHelper,
    private authService: AuthenticationService,
    private httpClient: HttpClient) {
  }

  public getAttachments(boardId: number, stackId: number, cardId: number): Promise<Array<Attachement>> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling updateCard.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling updateCard.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling updateCard.');
    }
    return this.authService.getAccount().then((account) => {
        return firstValueFrom(this.httpClient.get<Array<Attachement>>(`${account.url}/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}`,
          this.serviceHelper.getHttpOptions(account)
        ))
      }
    )
  }
}
