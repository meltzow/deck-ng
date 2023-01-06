import { Component, Input, OnInit } from '@angular/core';
import { Board } from "@app/model/board";
import { StackService } from "@app/services";
import { Stack } from "@app/model";
import { BehaviorSubject, firstValueFrom } from "rxjs";

@Component({
  selector: 'app-board-preview',
  templateUrl: './board-preview.component.html',
  styleUrls: ['./board-preview.component.css']
})
export class BoardPreviewComponent implements OnInit {
  @Input() board: Board;
  stacks = new BehaviorSubject<Stack[]>(null)
  stacksLoading = true;
  constructor(private stackService: StackService) { }

  ngOnInit(): void {
    this.getStacks()
  }

  getStacks() {
    if (!this.board) return
      this.stackService.getStacks(this.board.id).then(value => {
        this.stacks.next(value);
      }).finally(() =>
        this.stacksLoading = false
      );
  }

  async getCardCount(boardId: number): Promise<number> {
    let sum = 0
    await this.stacks.value.filter(stack => stack.boardId == boardId).forEach(stack => sum += stack.cards.length)
    return sum
  }
}
