import { Injectable } from '@angular/core';
import { BoardItem } from "@app/model/boardItem";
import { AuthenticationService } from "@app/services/authentication.service";
import { environment } from "@environments/environment";

@Injectable({
  providedIn: 'root'
})
export class BoardService {
  public baseUrl = `${environment.nextcloudApiUrl}/boards`

  constructor(private authService: AuthenticationService) { }

  private getHeaders(): HeadersInit {
    return {
      'Authorization': 'Basic ' + this.authService.userValue.authdata
      //TODO add more headers
      // oCSAPIRequest: string, ifModifiedSince?: string
    }
  }

  public boards(): Promise<Array<BoardItem>> {
    return fetch(this.baseUrl, {
        referrerPolicy: 'no-referrer',
        headers: this.getHeaders()
      }).then( res => {
        if (!res.ok) {
          throw new Error(res.statusText)
        }
        return res.json() as Promise<Array<BoardItem>>
      })
  }

  public getBoard(id: number): Promise<BoardItem> {
    return fetch(this.baseUrl + "/" + id, {
      headers: this.getHeaders()
    }).then(res => {
      return res.json() as Promise<BoardItem>
    })
  }
}
