import { Component, OnInit } from '@angular/core';
import { BehaviorSubject } from "rxjs";
import { AuthenticationService, config, ConfigService } from "@app/services";
import { BoardService } from "@app/services";
import { NotificationService } from "@app/services/notification.service";
import { Board } from "@app/model";
import { CardsService } from "@app/services/cards.service";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  isLoading = new BehaviorSubject<boolean>(true);

  boards = new BehaviorSubject<Board[]>([])

  constructor(
    private boardService: BoardService,
    public notification: NotificationService,
    private authService: AuthenticationService,
    private configService: ConfigService
  ) {
  }

  async ionViewWillEnter() {
    await this.getBoards();
  }
  async ngOnInit() {
    await this.authService.ngOnInit()

  }

  async getBoards() {
    this.isLoading.next(true)
    const b = await this.boardService.getBoards()
    this.boards.next(b)
    this.isLoading.next(false)
  }

  doRefresh(event) {
    this.getBoards()
    event.target.complete();
  }

  async saveConfig() {
    const c = new config()
    c.age = 10
    c.bar = false
    this.configService.writeConfig(c).subscribe(value => console.log(value))
  }
}
