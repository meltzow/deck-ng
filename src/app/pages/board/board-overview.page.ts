import { Component, OnInit } from '@angular/core';
import { BoardItem } from "@app/model/boardItem";
import { ToastController } from "@ionic/angular";
import { BehaviorSubject, firstValueFrom } from "rxjs";
import { AuthenticationService } from "@app/services";
import { BoardService } from "@app/services";
import { NotificationService } from "@app/services/notification.service";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  isLoading = new BehaviorSubject<boolean>(true);
  boards = new BehaviorSubject<BoardItem[]>([]);

  constructor(
    private boardService: BoardService,
    public notification: NotificationService,
    private authService: AuthenticationService
  ) {
  }

  async ngOnInit() {
    await this.authService.ngOnInit()
    this.getBoards();
  }

  getBoards() {
    this.isLoading.next(true)
    this.boardService.getBoards().subscribe(
      {
        next: (boards: BoardItem[]) => this.boards.next(boards),
        error: (err: Error) => this.notification.error(err.message),
        complete: () => this.isLoading.next(false)
      })
  }

  doRefresh(event) {
    this.getBoards()
    event.target.complete();
  }

}
