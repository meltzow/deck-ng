import { Component, OnInit, ViewChild } from '@angular/core';
import { Card } from "@app/model/card";
import { CardsService } from "@app/services/cards.service";
import { ActivatedRoute } from "@angular/router";
import { Board, Label } from "@app/model";
import { BoardService } from "@app/services";
import { MarkdownService } from "@app/services/markdown.service";
import { SafeHtml } from "@angular/platform-browser";
import { IonDatetimeButton } from "@ionic/angular";
import { NotificationService } from "@app/services/notification.service";


@Component({
  selector: 'app-card-details',
  templateUrl: './card-details.page.html',
  styleUrls: ['./card-details.page.css']
})
export class CardDetailsPage implements OnInit {
  private cardId: number
  card: Card
  boardId: number
  board: Board
  private stackId: number

  descEditable = false
  plainText: string;
  content: SafeHtml;
  isLoading = true

  @ViewChild("textareaDescription") textareaDescription;
  @ViewChild("datetime") datetime;
  @ViewChild("datetimeButton") datetimeButton: IonDatetimeButton;
  dueDate: string;
  isPopoverOpen: boolean;
  constructor(private cardService: CardsService,
              private boardService: BoardService,
              private activatedRoute: ActivatedRoute,
              private markDownService: MarkdownService,
              private notificationService: NotificationService) {
  }

  ngOnInit(): void {
    this.boardId = parseInt(this.activatedRoute.snapshot.paramMap.get('boardId'), 10)
    this.stackId = parseInt(this.activatedRoute.snapshot.paramMap.get('stackId'), 10)
    this.cardId = parseInt(this.activatedRoute.snapshot.paramMap.get('cardId'), 10)
  }

  ionViewWillEnter() {
    this.doRefresh()
  }

  async doRefresh() {
    this.isLoading = true
    const card = await this.cardService.getCard(this.boardId, this.stackId, this.cardId)
    this.card = card
    this.dueDate = card.duedate ? new Date(card.duedate).toISOString() : ""
    this.plainText = card.description
    this.content = card.description ? this.markDownService.render(card.description):'add description'
    this.board = card.relatedBoard
    this.isLoading = false
  }

  convert(this) {
    if (this.toggleVal == true) {
      if (this.plainText && this.plainText != '') {
        const plainText = this.plainText
        this.markdownText = this.markdownService.parse(plainText.toString())
        this.content = this.markdownText
      } else {
        this.toggleVal = false
        this.content = 'add description'
      }
    }
  }

  changeTitle($event: string) {
    this.card.title = $event
    this.updateCard()
  }

  async updateCard() {
    this.isLoading = true
    this.card = await this.cardService.updateCard(this.boardId, this.card.stackId, this.card.id, this.card).finally(() => this.isLoading = false)
    this.notificationService.msg("card successfully updated")
  }

  handleLabelChange($event: any) {
    const before = this.card.labels.map(value => value.id)
    const after = $event.detail.value.map(value => value.id)
    const removed = before.filter((x) => !after.includes(x));
    const added = after.filter((x) => !before.includes(x));
    //TODO: enable loading
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
    this.content = this.markDownService.render(this.card.description)
    this.descEditable = false
    this.updateCard()
  }

  onFocusDescription() {
    this.descEditable = true
    this.textareaDescription.setFocus()
  }

  getFirstDayOfWeek(): number {
    return (new Intl.Locale(navigator.language) as any).weekInfo.firstDay
  }

  ionChange(event: any) {
    if (!event) {
      this.dueDate = null
    }
    if (this.dueDate != this.card.duedate) {
      this.card.duedate = this.dueDate
      this.updateCard()
    }
  }

  openStart() {
    this.datetime.open()
  }
}
