import { Component, OnInit } from '@angular/core';
import { Card } from "@app/model/card";
import { BehaviorSubject } from "rxjs";
import { BoardItem } from "@app/model/boardItem";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
  public card: BehaviorSubject<Card> = new BehaviorSubject({title: "foobar"});

  constructor() { }

  ngOnInit(): void {
  }

  doRefresh($event: any) {

  }

  getBackButtonText() {
    const win = window as any;
    const mode = win && win.Ionic && win.Ionic.mode;
    return mode === 'ios' ? 'Inbox' : '';
  }
}
