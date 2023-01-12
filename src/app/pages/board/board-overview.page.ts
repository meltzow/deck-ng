import { Component, OnInit } from '@angular/core';
import { BehaviorSubject } from "rxjs";
import { AuthenticationService, OverviewService } from "@app/services";
import { BoardService } from "@app/services";
import { Board, Upcoming } from "@app/model";

@Component({
  selector: 'app-board-overview',
  templateUrl: 'board-overview.page.html',
  styleUrls: ['board-overview.page.scss'],
})
export class BoardOverviewPage implements OnInit {
  isLoading = new BehaviorSubject<boolean>(true);

  boards:BehaviorSubject<Board[]> = new BehaviorSubject<Board[]>(null)
  upcomings: BehaviorSubject<Upcoming[]>

  constructor(
    private boardService: BoardService,
    private authService: AuthenticationService,
    private overviewService: OverviewService
  ) {
  }

  async ionViewWillEnter() {
    await this.getBoards()
    await this.getUpcoming()
    await this.overviewService.getCapabilities()
  }
  async ngOnInit() {
    await this.authService.ngOnInit()
    this.boards.subscribe(this.boardService.currentBoardsSubj)
    this.upcomings.subscribe(this.overviewService.currentUpcomingsSubj)
  }

  async getBoards() {
    this.isLoading.next(true)
    const b = await this.boardService.getBoards()
    this.boards.next(b)
    this.isLoading.next(false)
  }

  async getUpcoming() {
    this.isLoading.next(true)
    await this.overviewService.upcoming()
    this.isLoading.next(false)
  }

  doRefresh(event) {
    this.getBoards()
    this.getUpcoming()
    event.target.complete();
  }

  assigneeName(upcoming: Upcoming) {
    return this.overviewService.getAssigneesNames(upcoming)
  }

}
