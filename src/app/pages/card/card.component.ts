import { Component, OnInit } from '@angular/core';
import { Card } from "@app/model/card";
import { BehaviorSubject } from "rxjs";
import { BoardItem } from "@app/model/boardItem";
import { CardsService } from "@app/services/cards.service";
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
  public card: BehaviorSubject<Card> = new BehaviorSubject({title: "foobar"});
  private boardId;
  private stackId;
  private cardId;

  constructor(private cardSevice: CardsService, private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('boardId');
    this.stackId = this.activatedRoute.snapshot.paramMap.get('stackId');
    this.cardId = this.activatedRoute.snapshot.paramMap.get('cardId');
    this.doRefresh()
  }

  doRefresh() {
      this.cardSevice.getCard(this.boardId, this.stackId, this.cardId).subscribe(value => {
        this.card.next(value)
      })
  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }
}
