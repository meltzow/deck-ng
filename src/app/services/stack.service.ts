import { Injectable } from '@angular/core';
import { environment } from "@environments/environment";
import { AuthenticationService } from "@app/services/authentication.service";
import { StackItem } from "@app/model";

@Injectable({
  providedIn: 'root'
})
export class StackService {

  public baseUrl(boardId: number): string {
    return `${environment.nextcloudApiUrl}/boards/${boardId}/stacks`
  }

  constructor(private authService: AuthenticationService) { }

  private getHeaders(): HeadersInit {
    return {
      'Authorization': 'Basic ' + this.authService.userValue.authdata
      //TODO add more headers
      // oCSAPIRequest: string, ifModifiedSince?: string
    }
  }

  public getStacks(boardId: number): Promise<Array<StackItem>> {
      return fetch(this.baseUrl(boardId), {
        referrerPolicy: 'no-referrer',
        headers: this.getHeaders()
      }).then( res => {
        if (!res.ok) {
          throw new Error(res.statusText)
        }
        return res.json() as Promise<Array<StackItem>>
      })
    }
}
