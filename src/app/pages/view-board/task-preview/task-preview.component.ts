import { Component, Input, OnInit } from '@angular/core';
import { Card } from "@app/model/card";
import { DefaultService } from "@app/api/default.service";
import { BoardItem } from "@app/model/boardItem";
import {Md5} from "md5-typescript";
import { CardsService } from "@app/services/cards.service";

@Component({
  selector: 'app-task-preview',
  templateUrl: './task-preview.component.html',
  styleUrls: ['./task-preview.component.css']
})
export class TaskPreviewComponent implements OnInit {

  @Input() card: Card;
  @Input() board: BoardItem

  constructor(private cardService: CardsService) {
  }

  ngOnInit(): void {
  }

  changeTitle($event: string) {
    console.log ("the new String value: " + $event)
    this.card.title = $event
    this.cardService.updateCard(this.board.id, this.card.stackId, this.card.id, this.card).subscribe(value => console.log(value),error => console.warn(error))
  }

  md5(): string {
    return Md5.init(this.card.title)
  }
}
