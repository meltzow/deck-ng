import { Injectable } from '@angular/core';
import { Card } from "@app/model/card";
import { firstValueFrom } from "rxjs";
import { HttpClient } from "@angular/common/http";
import { AuthenticationService } from "@app/services/authentication.service";
import { HttpService } from "@app/services/http.service";

@Injectable({
  providedIn: 'root'
})
export class CardsService {

  constructor(private httpService: HttpService) {
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

    return this.httpService.get(`index.php/apps/deck/api/v1/boards/${encodeURIComponent(String(boardId))}/stacks/${encodeURIComponent(String(stackId))}/cards/${encodeURIComponent(String(cardId))}`)
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

    return this.httpService.put(`index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}`, card)
  }

  public assignLabel2Card(boardId: number, stackId: number, cardId: number, labelId: number): Promise<Card> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling assignLabel2Card.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling assignLabel2Card.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling assignLabel2Card.');
    }
    if (labelId === null || labelId === undefined) {
      throw new Error('Required parameter labelId was null or undefined when calling assignLabel2Card.');
    }

      return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/assignLabel`,
        {labelId:labelId})
  }

  public removeLabel2Card(boardId: number, stackId: number, cardId: number, labelId: number): Promise<Card> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling assignLabel2Card.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling assignLabel2Card.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling assignLabel2Card.');
    }
    if (labelId === null || labelId === undefined) {
      throw new Error('Required parameter labelId was null or undefined when calling assignLabel2Card.');
    }

      return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/removeLabel`,
        {labelId:labelId})
  }

  public assignUser2Card(boardId: number, stackId: number, cardId: number, userId: number): Promise<Card> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling assignLabel2Card.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling assignLabel2Card.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling assignLabel2Card.');
    }
    if (userId === null || userId === undefined) {
      throw new Error('Required parameter labelId was null or undefined when calling assignLabel2Card.');
    }

      return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/assignUser`,
        {userId:userId})
  }

  public unassignUser2Card(boardId: number, stackId: number, cardId: number, userId: number): Promise<Card> {

    if (boardId === null || boardId === undefined) {
      throw new Error('Required parameter boardId was null or undefined when calling assignLabel2Card.');
    }
    if (stackId === null || stackId === undefined) {
      throw new Error('Required parameter stackId was null or undefined when calling assignLabel2Card.');
    }
    if (cardId === null || cardId === undefined) {
      throw new Error('Required parameter cardId was null or undefined when calling assignLabel2Card.');
    }
    if (userId === null || userId === undefined) {
      throw new Error('Required parameter labelId was null or undefined when calling assignLabel2Card.');
    }

      return this.httpService.put<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards/${cardId}/unassignUser`,
        {userId:userId})
  }

  async createCard(boardId: number, stackId: number,  card: Card): Promise<Card > {
      return this.httpService.post<Card>(`/index.php/apps/deck/api/v1/boards/${boardId}/stacks/${stackId}/cards`, card)
  }
}
