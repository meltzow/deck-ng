import { Component, OnInit } from '@angular/core';
import { Card } from "@app/model/card";
import { BehaviorSubject } from "rxjs";
import { BoardItem } from "@app/model/boardItem";
import { CardsService } from "@app/services/cards.service";
import { ActivatedRoute } from "@angular/router";
import * as marked from 'marked';
import { MarkdownService } from "ngx-markdown";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
  public card: BehaviorSubject<Card> = new BehaviorSubject({});
  boardId;
  private stackId;
  private cardId;
  toggleVal: boolean;
  plainText: string;
  content: string;

  constructor(private cardService: CardsService,
              private activatedRoute: ActivatedRoute,
              private markdownService: MarkdownService) { }

  ngOnInit() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('boardId');
    this.stackId = this.activatedRoute.snapshot.paramMap.get('stackId');
    this.cardId = this.activatedRoute.snapshot.paramMap.get('cardId');
    this.doRefresh()
  }

  doRefresh() {
      this.cardService.getCard(this.boardId, this.stackId, this.cardId).then(value => {
        this.card.next(value)
        this.plainText = value.description
        this.content = this.markdownService.parse(value.description)
      })
  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }

  convert(this) {
    console.log(this.toggleVal);
    if(this.toggleVal==true){
      if(this.plainText && this.plainText!=''){
        const plainText = this.plainText

        this.markdownText = this.markdownService.parse(plainText.toString())
        this.content = this.markdownText
      }else{
        this.toggleVal=false
      }
    }
  }
}
