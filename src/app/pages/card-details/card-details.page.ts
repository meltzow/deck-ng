import {Component, OnInit, ViewChild} from '@angular/core';
import {Card} from "@app/model/card";
import {CardsService} from "@app/services/cards.service";
import {ActivatedRoute, Router} from "@angular/router";
import {Board, Label} from "@app/model";
import {BoardService} from "@app/services";
import {MarkdownService} from "@app/services/markdown.service";
import {SafeHtml} from "@angular/platform-browser";
import {AlertController, IonDatetimeButton} from "@ionic/angular";
import {NotificationService} from "@app/services/notification.service";
import {Camera, CameraResultType} from "@capacitor/camera";
import {Assignment} from "@app/model/assignment";


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

  @ViewChild("image") imageElement
  @ViewChild("textareaDescription") textareaDescription;
  @ViewChild("datetime") datetime;
  isPopoverOpen: boolean;

  constructor(private cardService: CardsService,
              private boardService: BoardService,
              private activatedRoute: ActivatedRoute,
              private markDownService: MarkdownService,
              private notificationService: NotificationService,
              private alertController: AlertController,
              private router: Router) {
  }

  ngOnInit(): void {
    this.boardId = parseInt(this.activatedRoute.snapshot.paramMap.get('boardId'), 10)
    this.stackId = parseInt(this.activatedRoute.snapshot.paramMap.get('stackId'), 10)
    this.cardId = parseInt(this.activatedRoute.snapshot.paramMap.get('cardId'), 10)
  }

  ionViewWillEnter() {
    this.doRefresh()
  }

  async doRefresh(event?) {
    this.isLoading = true
    const card = await this.cardService.getCard(this.boardId, this.stackId, this.cardId)
    this.card = card
    this.plainText = card.description
    this.content = card.description ? this.markDownService.render(card.description) : 'add description'
    this.board = await this.boardService.getBoard(this.boardId)
    this.isLoading = false
    event?.target.complete();
  }

  convert(this) {
    if (this.toggleVal == true) {
      if (this.plainText && this.plainText != '') {
        const plainText = this.plainText
        this.markdownText = this.markdownService.parse(plainText.toString())
        this.content = this.markdownText ? this.markdownText : 'add description'
      } else {
        this.toggleVal = false
        this.content = 'add description'
      }
    }
  }

  changeTitle(newTitel: string) {
    if (newTitel != this.card.title) {
      this.card.title = newTitel
      this.updateCard()
    }
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
      this.cardService.removeLabel2Card(this.boardId, this.card.stackId, this.card.id, id)
    })
    added.forEach((id) => {
      this.cardService.assignLabel2Card(this.boardId, this.card.stackId, this.card.id, id)
    })
  }

  async handleAssigneeChange($event: any) {
    const before = this.card.assignedUsers.map(value => value.participant.uid)
    const after = $event.detail.value
    const removed = before.filter((x) => !after.includes(x));
    const added = after.filter((x) => !before.includes(x));
    this.isLoading = true
    for (const id of removed) {
      await this.cardService.unassignUser2Card(this.boardId, this.card.stackId, this.card.id, id)
    }
    for (const id of added) {
      await this.cardService.assignUser2Card(this.boardId, this.card.stackId, this.card.id, id)
    }
    await this.doRefresh()
  }

  userPreselected(assignment: Assignment | string, uid: string): boolean {
    if (assignment && (assignment as Assignment).participant !== undefined) {
      return (assignment as Assignment).participant.uid == uid
    } else {
      return assignment == uid
    }
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

  dueDateResetBtnClick() {
    this.card.duedate = null
    this.datetime.cancel(true)
    this.updateCard()
  }

  dueDateCancelBtnClick() {
    this.datetime.cancel(true)
  }


  dueDateDoneBtnClick() {
    this.datetime.confirm(true)
    this.updateCard()
  }

  async confirmDelete() {
    const alert = await this.alertController.create({
      header: 'Confirmation Delete',
      message: 'Are you sure you want to delete this issue ?',
      backdropDismiss: false,
      cssClass: 'confirm-exit-alert',
      buttons: [{
        text: 'cancel',
        role: 'cancel',
        handler: () => {
          console.log('deletion not confirmed');
        }
      }, {
        text: 'delete',
        handler: () => {
          this.isLoading = true
          this.cardService.deleteCard(this.boardId, this.stackId, this.cardId)
            .then(value => {
              this.notificationService.msg('card successfully deleted')
              this.router.navigate(['/boards', this.boardId]);
            })
            .catch(reason => this.notificationService.error(reason))
            .finally(() => this.isLoading = false )
        }
      }]
    });

    await alert.present();
  }

  async takePicture($event: MouseEvent) {
    const image = await Camera.pickImages({
      quality: 90,
      limit: 1
    });

    // image.webPath will contain a path that can be set as an image src.
    // You can access the original file using image.path, which can be
    // passed to the Filesystem API to read the raw data of the image,
    // if desired (or pass resultType: CameraResultType.Base64 to getPhoto)
    const imageUrl = image.photos[0].webPath;

    // Can be set to the src of an image now
    this.imageElement.src = imageUrl;
  }
}
