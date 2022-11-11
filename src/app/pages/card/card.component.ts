import { Component, OnInit, ViewChild } from '@angular/core';
import { Card } from "@app/model/card";
import { CardsService } from "@app/services/cards.service";
import { ActivatedRoute } from "@angular/router";
import { MarkdownService } from "ngx-markdown";
import { BoardItem, Label } from "@app/model";
import { BoardService } from "@app/services";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
  private cardId: number
  card: Card
  boardId: number
  board: BoardItem
  private stackId: number

  descEditable = false
  plainText: string;
  content: string;
  isLoading = true
  @ViewChild("textareaDescription") textareaDescription;

  constructor(private cardService: CardsService,
              private boardService: BoardService,
              private activatedRoute: ActivatedRoute,
              private markdownService: MarkdownService) {
  }

  ngOnInit() {
    this.boardId = parseInt(this.activatedRoute.snapshot.paramMap.get('boardId'), 10)
    this.stackId = parseInt(this.activatedRoute.snapshot.paramMap.get('stackId'), 10)
    this.cardId = parseInt(this.activatedRoute.snapshot.paramMap.get('cardId'), 10)
    this.doRefresh()
  }

  doRefresh() {
    this.isLoading = true
    Promise.all([
      this.cardService.getCard(this.boardId, this.stackId, this.cardId),
      this.boardService.getBoard(this.boardId)]
    ).then(([card, board]) => {
      this.card = card
      this.plainText = card.description
      this.content = this.markdownService.parse(card.description)
      this.board = board
      this.isLoading = false
    })
  }

  convert(this) {
    if (this.toggleVal == true) {
      if (this.plainText && this.plainText != '') {
        const plainText = this.plainText
        this.markdownText = this.markdownService.parse(plainText.toString())
        this.content = this.markdownText
      } else {
        this.toggleVal = false
      }
    }
  }

  changeTitle($event: string) {
    this.card.title = $event
    this.updateCard()
  }

  updateCard() {
    this.cardService.updateCard(this.boardId, this.card.stackId, this.card.id, this.card).then(value => console.log(value), error => console.warn(error))
  }

  handlabelChange($event: any) {
    const before = this.card.labels.map(value => value.id)
    const after = $event.detail.value.map(value => value.id)
    const removed = before.filter((x) => !after.includes(x));
    const added = after.filter((x) => !before.includes(x));
    removed.forEach((id) => {
        this.cardService.removeLabel2Card(this.boardId, this.card.stackId, this.card.id,id)
      })
    added.forEach((id) => {
      this.cardService.assignLabel2Card(this.boardId, this.card.stackId, this.card.id, id)
    })
  }

  labelPreselected(label1: Label, label2: Label): boolean {
    return label1 && label2 ? label1.id === label2.id : label1 === label2;
  }

  onBlurDescription() {
    this.card.description = this.plainText
    this.content = this.markdownService.parse(this.card.description)
    this.descEditable = false
    this.updateCard()
  }

  onFocusDescription() {
    console.log("onFocusDescription")
    this.descEditable = true
    this.textareaDescription.setFocus()
  }
}
