import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Board } from "@app/model/board";
import { BehaviorSubject, firstValueFrom, Subscription, timeout } from "rxjs";
import { Stack } from "@app/model/stack";
import { Card } from "@app/model/card";
import {
  AlertController,
  IonContent,
  IonicSlides,
  IonModal,
  IonSegment,
  IonSlides,
  ItemReorderEventDetail
} from "@ionic/angular";
import { BoardService, StackService } from "@app/services";
import { OverlayEventDetail } from '@ionic/core/components';
import { CardsService } from "@app/services/cards.service";
import { NotificationService } from "@app/services/notification.service";
import { TranslateService } from "@ngx-translate/core";
// import SwiperCore, {  Pagination, SwiperOptions, Swiper } from 'swiper';
import { CdkDragDrop, CdkDragMove, CdkDragRelease, moveItemInArray, transferArrayItem } from "@angular/cdk/drag-drop";

// SwiperCore.use([Pagination, IonicSlides]);

@Component({
  selector: 'app-view-board',
  templateUrl: './board-details.page.html',
  styleUrls: ['./board-details.page.scss'],
})
export class BoardDetailsPage implements OnInit {
  slideOpts = {
    initialSlide: 1,
    speed: 400
  };
  public board: BehaviorSubject<Board> = new BehaviorSubject(null);
  stacks: BehaviorSubject<Stack[]> = new BehaviorSubject<Stack[]>(null)
  private searchedCards: Card[];
  private boardId;
  @ViewChild(IonContent) foobar;
  @ViewChild(IonModal) modal: IonModal
  @ViewChild('swiper') slideWithNav: IonSlides;
  @ViewChild(IonSegment) segment: IonSegment
  isLoading = true;
  selectedStack: Stack
  private alreadySwitched: boolean;
  public reorderAllowed = true;

  constructor(
    private boardService: BoardService,
    private stackService: StackService,
    private activatedRoute: ActivatedRoute,
    public notificationService: NotificationService,
    private alertController: AlertController,
    private cardService: CardsService,
    private translateService: TranslateService
  ) { }

  async ngOnInit() {
    this.boardId = this.activatedRoute.snapshot.paramMap.get('id');
  }

  private async getBoard(id: string) {
    this.isLoading = true
    const board = await this.boardService.getBoard(parseInt(id, 10))
    this.board.next(board)
    const stacks = await this.stackService.getStacks(parseInt(id, 10)).finally(() => this.isLoading = false)
    this.stacks.next(stacks)
    this.selectedStack = (stacks.length ? (this.selectedStack? this.selectedStack : stacks[0] ): null )
  }

  async promptTitle() {
    const header = await firstValueFrom(this.translateService.get('enter_title'))
    const cancel = await firstValueFrom(this.translateService.get('cancel'))
    const titlePlaceholder = await firstValueFrom(this.translateService.get('title_placeholder'))

      const alert = await this.alertController.create({
        header: header,
        buttons: [{
          text: cancel,
          role: 'cancel'
        },
          {
            text: 'OK',
            role: 'confirm',
            handler: (data) => {
              this.confirmHandler(data);
            },
          },],
        inputs: [
          {
            name: 'title',
            placeholder: titlePlaceholder,
          },
        ],
      });

      await alert.present();
  }

  confirmHandler(data: { title: string }) {
    const c = new Card()
    c.title = data.title
    c.stackId = this.selectedStack.id
    this.isLoading = true
    this.cardService.createCard(this.boardId, this.selectedStack.id, c)
      .then(value => {
        this.notificationService.msg('card successfully created')
        this.getBoard(this.boardId)
      })
      .catch(reason => this.notificationService.error(reason))
      .finally(() => this.isLoading = false )
  }
  doRefresh(event) {
    this.board.next(null)
    this.stacks.next([])
    this.getBoard(this.boardId)
  }

  cancel() {
    this.modal.dismiss(null, 'cancel');
  }

  confirm() {
    this.modal.dismiss(null, 'confirm');
  }

  async ionViewWillEnter() {
    await this.getBoard(this.boardId);
  }

  onWillDismiss(event: Event) {
    const ev = event as CustomEvent<OverlayEventDetail<string>>;
    if (ev.detail.role === 'confirm') {
      //this.message = `Hello, ${ev.detail.data}!`;
      console.log("filter confirmed")
    }
  }

  segmentChanged(ev: any) {
    this.selectedStack = ev.detail.value
    // this.slideTo(this.selectedStack)
  }

  stackIsSelected(): boolean {
    return this.selectedStack?.id > -1
  }

  // private slideTo(stack: Stack) {
  //
  //   this.slideWithNav.slideTo(stack.id);
  // }

  // private switchSegment(stack: Stack) {
  //   this.segment.value = stack as any
  // }

  // onSwiper(event) {
  //   console.log(event);
  // }

  // async onSlideChange(ev: any) {
  //   const index = this.slideWithNav.activeIndex;
  //   this.clickSegment(index)
  // }

  // public slideDidChange() {
  //   console.log('Slide did change');
  //
  //   if (!this.slideWithNav) return;
  //
  //   console.table({
  //     isBeginning: this.slideWithNav.isBeginning,
  //     isEnd: this.slideWithNav.isEnd
  //   });
  // }

  // public slideWillChange() {
  //   console.log('Slide will change');
  // }

  // drop(event: CdkDragDrop<Card[]>) {
  //   // this.slideWithNav.lockSwipes(false)
  //   console.log("DROP result: same container: " + (event.previousContainer === event.container))
  //   if (event.previousContainer === event.container) {
  //     moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
  //     //TODO: find out card above my new position. If there is none, we must set card.order = 0
  //     // const currentStackCards = event.container.data;
  //     // const cardAbove = currentStackCards[event.currentIndex - 1]
  //     // if (cardAbove) {
  //     //
  //     // } else {
  //     //   event.container.d
  //     // }
  //   } else {
  //     transferArrayItem(
  //       event.previousContainer.data,
  //       event.container.data,
  //       event.previousIndex,
  //       event.currentIndex,
  //     );
  //     const cardAbove = event.container.data[event.currentIndex - 1]
  //     let newIndex = 0
  //     if (cardAbove) {
  //       newIndex = cardAbove.order + 1
  //     }
  //     const droppedCard = event.item.data
  //     droppedCard.order = newIndex
  //     this.cardService.updateCard(this.boardId, droppedCard.stackId, droppedCard.id, droppedCard)
  //   }
  //   //
  // }
  // switchToSegmentAtLeft(card: Card) {
  //   this.slideWithNav.lockSwipes(false)
  //   this.slideWithNav.slidePrev()
  //   // const idx = this.stacks.value.findIndex((value, index, array) => value.id == this.selectedStack.id)
  //   // const nextLeftStack = this.stacks.value[idx - 1]
  //   // if (nextLeftStack) {
  //   //   card.stackId = nextLeftStack.id
  //   //   this.switchSegment(nextLeftStack)
  //   //
  //   // }
  // }
  //
  // switchToSegmentAtRight(card: Card) {
  //   this.slideWithNav.lockSwipes(false)
  //   this.slideWithNav.slideNext()
  //
  //   // const idx = this.stacks.value.findIndex((value, index, array) => value.id == this.selectedStack.id)
  //   // const nextRightStack = this.stacks.value[idx + 1]
  //   // if (nextRightStack) {
  //   //   card.stackId = nextRightStack.id
  //   //   this.switchSegment(nextRightStack)
  //   //
  //   // }
  // }

  // drag($event: CdkDragMove<Card>) {
  //   this.slideWithNav.lockSwipes(true)
  //   const viewBoundaryRight = window.innerWidth
  //   const pointerHorizontal = $event.pointerPosition.x
  //   const offset = 100
  //   if (!this.alreadySwitched && pointerHorizontal < (0 + offset)) {
  //     this.alreadySwitched = true
  //     this.switchToSegmentAtLeft($event.source.data)
  //     // this.cardService.updateCard(this.boardId, $event.source.data.stackId, $event.source.data.id, $event.source.data)
  //   } else if (!this.alreadySwitched && pointerHorizontal > (viewBoundaryRight - offset)) {
  //     this.alreadySwitched = true
  //     this.switchToSegmentAtRight($event.source.data)
  //     // this.cardService.updateCard(this.boardId, $event.source.data.stackId, $event.source.data.id, $event.source.data)
  //   } else if (pointerHorizontal < (viewBoundaryRight - offset) && pointerHorizontal > (0 + offset)) {
  //     this.alreadySwitched = false
  //   }
  // }

  getCardsArrayByCard(card: Card): Card[] {
    if (card) {
      return this.stacks.value.find((value) => value.id == card.stackId).cards
    }
  }

  getCardsArray(): BehaviorSubject<Card[]> {
    return new BehaviorSubject<Card[]>(this.stacks.value.flatMap((value) => value.cards))
  }

  handleReorder(ev: CustomEvent<ItemReorderEventDetail>) {
    // The `from` and `to` properties contain the index of the item
    // when the drag started and ended, respectively
    console.log('Dragged from index', ev.detail.from, 'to', ev.detail.to);

    // Finish the reorder and position the item in the DOM based on
    // where the gesture ended. This method can also be called directly
    // by the reorder group
    ev.detail.complete();
  }

  swiptToRight(ev): void {
    console.log(ev)
  }
}
