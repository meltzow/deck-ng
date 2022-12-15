import { Component, Input, OnInit } from '@angular/core';
import { Board } from "@app/model/board";
import { StackService } from "@app/services";
import { Stack } from "@app/model";
import { BehaviorSubject, firstValueFrom } from "rxjs";

@Component({
  selector: 'app-dashboard-widget',
  templateUrl: './board-card.component.html',
  styleUrls: ['./board-card.component.css']
})
export class BoardCardComponent implements OnInit {
  @Input() board: Board;
  stacks = new BehaviorSubject<Stack[]>(null)
  stacksLoading = true;

  constructor(private stackService: StackService) { }

  ngOnInit(): void {
    this.getStacks()
  }

  getStacks() {
    if (!this.board) return
    return firstValueFrom(this.stackService.getStacks(this.board.id)).then(value => {
      this.stacks.next(value);
    }).finally(() =>
      this.stacksLoading = false
    );
  }
}
