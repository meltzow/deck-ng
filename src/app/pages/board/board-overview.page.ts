import { Component, OnInit } from '@angular/core';
import { BehaviorSubject } from "rxjs";
import { AuthenticationService, OverviewService } from "@app/services";
import { BoardService } from "@app/services";
import { Board, UpcomingResponse } from "@app/model";
import { CardsService } from "@app/services/cards.service";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  isLoading = new BehaviorSubject<boolean>(true);

  boards = new BehaviorSubject<Board[]>([])
  upcomings = new BehaviorSubject<UpcomingResponse>(new UpcomingResponse());

  constructor(
    private boardService: BoardService,
    private authService: AuthenticationService,
    private overviewService: OverviewService
  ) {
  }

  async ionViewWillEnter() {
    await this.getBoards()
    await this.getUpcoming()
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

  async getUpcoming() {
    this.isLoading.next(true)
    const b = await this.overviewService.upcoming()
    this.upcomings.next(b)
    this.isLoading.next(false)
  }

  doRefresh(event) {
    this.getBoards()
    this.getUpcoming()
    event.target.complete();
  }

}
