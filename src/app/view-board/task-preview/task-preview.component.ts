import { Component, Input, OnInit } from '@angular/core';
import { Card } from "@app/model/card";
import { DefaultService } from "@app/api/default.service";
import { $e } from "@angular/compiler/src/chars";
import { StackItem } from "@app/model/stackItem";
import { BoardItem } from "@app/model/boardItem";

@Component({
  selector: 'app-task-preview',
  templateUrl: './task-preview.component.html',
  styleUrls: ['./task-preview.component.css']
})
export class TaskPreviewComponent implements OnInit {

  @Input() card: Card;
  @Input() board: BoardItem

  constructor(private cardService: DefaultService) {
  }

  ngOnInit(): void {
  }

  changeTitle($event: string) {
    console.log ("the new String value: " + $event)
    this.card.title = $event
    this.cardService.updateCard(this.board.id, this.card.stackId, this.card.id, "true",this.card).subscribe(value => console.log(value),error => console.warn(error))
  }
}
