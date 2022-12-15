import { Component, Input } from '@angular/core';
import { Card } from "@app/model/card";
import { Board } from "@app/model/board";
import {Md5} from "md5-typescript";
import { CardsService } from "@app/services/cards.service";

@Component({
  selector: 'app-task-preview',
  templateUrl: './task-preview.component.html',
  styleUrls: ['./task-preview.component.css']
})
export class TaskPreviewComponent {

  @Input() card: Card;
  @Input() board: Board
  @Input() selectedStack: number

  constructor(private cardService: CardsService) {
  }


  changeTitle($event: string) {
    console.log ("the new String value: " + $event)
    this.card.title = $event
    this.cardService.updateCard(this.board.id, this.card.stackId, this.card.id, this.card).then(value => console.log(value),error => console.warn(error))
  }

  md5(): string {
    return Md5.init(this.card.title)
  }
}