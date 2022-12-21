import { Component, Input, OnInit } from '@angular/core';
import { Board } from "@app/model/board";
import { AuthenticationService, StackService, ConfigService, config } from "@app/services";
import { participant, Stack } from "@app/model";
import { BehaviorSubject, firstValueFrom } from "rxjs";

@Component({
  selector: 'app-board-preview',
  templateUrl: './board-preview.component.html',
  styleUrls: ['./board-preview.component.css']
})
export class BoardPreviewComponent implements OnInit {
  @Input() board: Board;
  stacks = new BehaviorSubject<Stack[]>(null)
  stacksLoading = true;

  constructor(private stackService: StackService,
              private authService: AuthenticationService,
              private configService: ConfigService) { }

  ngOnInit(): void {
    this.getStacks()
  }

  getStacks() {
    if (!this.board) return
    return firstValueFrom(this.stackService.getStacks(this.board.id)).then(value => {
      this.stacks.next(value);
    }).finally(() =>
      this.stacksLoading = false
    );
  }

  getParticipants(): participant[] {
    return this.board.acl.map(value => value.participant)
  }

  async getUrl(): Promise<string> {
    const ac = await this.authService.getAccount()
    return ac.url
  }



}
