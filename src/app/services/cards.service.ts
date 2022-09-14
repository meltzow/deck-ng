import { Injectable } from '@angular/core';
import { Card } from "@app/model/card";
import { firstValueFrom } from "rxjs";
import { HttpClient } from "@angular/common/http";
import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper";

@Injectable({
  providedIn: 'root'
})
export class CardsService {

  constructor(protected httpClient: HttpClient, private authService: AuthenticationService, private serviceHelper: ServiceHelper) {
  }

  public getCard(boardId: number, stackId: number, cardId: number): Promise<Card> {
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
      return firstValueFrom(this.httpClient.get<Card>(`${account.url}/index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}/stacks/${encodeURIComponent(String(stackId))}/cards/${encodeURIComponent(String(cardId))}`,
        this.serviceHelper.getHttpOptions(account)
      ))
    })
  }

  /**
   * updates a card
   * @param boardId Numeric ID of the board to get
   * @param stackId Numeric ID of the stack to get
   * @param cardId Numeric ID of the card to get
   * @param card the card data
   */
  public updateCard(boardId: number, stackId: number, cardId: number, card: Card): Promise<Card> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling updateCard.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling updateCard.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling updateCard.');
    }
    if (card === null || card === undefined) {
      throw new Error('Required parameter card was null or undefined when calling updateCard.');
    }

    return this.authService.getAccount().then((account) => {
      return firstValueFrom(this.httpClient.put<Card>(`${account.url}/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}`,
        card,
        this.serviceHelper.getHttpOptions(account)
      ))
    })
  }
}
