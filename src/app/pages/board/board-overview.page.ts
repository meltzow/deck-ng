import { Component, OnInit } from '@angular/core';
import { BehaviorSubject } from "rxjs";
import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services";
import { NotificationService } from "@app/services/notification.service";
import { BoardItem } from "@app/model";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  isLoading = new BehaviorSubject<boolean>(true);

  boards = new BehaviorSubject<BoardItem>([])

  constructor(
    private boardService: BoardService,
    public notification: NotificationService,
    private authService: AuthenticationService
  ) {
  }

  async ngOnInit() {
    await this.authService.ngOnInit()
    await this.getBoards();
  }

  async getBoards() {
    this.isLoading.next(true)
    const b = await this.boardService.getBoardsProm()
    this.boards.next(b)
    this.isLoading.next(false)
  }

  doRefresh(event) {
    this.getBoards()
    event.target.complete();
  }

}
