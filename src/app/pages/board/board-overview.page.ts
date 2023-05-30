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
  isLoading = false

  boards:BehaviorSubject<Board[]> = new BehaviorSubject<Board[]>(null)
  upcomings: BehaviorSubject<Upcoming[]> = new BehaviorSubject<Upcoming[]>(null)

  constructor(
    private boardService: BoardService,
    private authService: AuthenticationService,
    private overviewService: OverviewService
  ) {
  }

  async ionViewWillEnter() {
    await this.getData()
    await this.overviewService.getCapabilities()
  }
  async ngOnInit() {
    await this.authService.ngOnInit()
    this.boards.subscribe(this.boardService.currentBoardsSubj)
    this.upcomings.subscribe(this.overviewService.currentUpcomingsSubj)
  }

  async getData() {
    this.isLoading = true
    this.boardService.getBoards().then(async value => {
      this.boards.next(value)
      await this.overviewService.upcoming()
    }).finally(() => this.isLoading = false)
  }



  doRefresh(event) {
    this.getData()
    event.target.complete();
  }

  assigneeName(upcoming: Upcoming) {
    return this.overviewService.getAssigneesNames(upcoming)
  }

}
