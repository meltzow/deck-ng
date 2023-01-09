import { Component, Input, OnInit } from '@angular/core';
import { Board } from "@app/model/board";
import { StackService } from "@app/services";
import { Stack } from "@app/model";
import { BehaviorSubject } from "rxjs";

@Component({
  selector: 'app-board-preview',
  templateUrl: './board-preview.component.html',
  styleUrls: ['./board-preview.component.css']
})
export class BoardPreviewComponent implements OnInit {
  @Input() board: Board;
  stacks = new BehaviorSubject<Stack[]>(null)
  stacksLoading = true;
  cardCount = new BehaviorSubject<number>(null)

  constructor(private stackService: StackService) {
  }

  async ngOnInit() {
    this.getStacks()
  }


  async getStacks() {
    if (!this.board) return
    const value = await this.stackService.getStacks(this.board.id).finally(() =>
      this.stacksLoading = false
    );
    this.stacks.next(value);
    this.cardCount.next(await this.getCardCount())
  }

  async getCardCount(): Promise<number> {
    let sum = 0
    this.stacks.value.filter(stack => stack.boardId == this.board.id).forEach(stack => sum += stack.cards? stack.cards.length : 0)
    return Promise.resolve(sum)
  }
}
