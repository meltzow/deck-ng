import { Component, Input, OnInit } from '@angular/core';
import { BoardItem } from "@app/model/boardItem";
import { StackService } from "@app/api/api";
import { StackItem } from "@app/model";
import { BehaviorSubject } from "rxjs";

@Component({
  selector: 'app-dashboard-widget',
  templateUrl: './dashboard-widget.component.html',
  styleUrls: ['./dashboard-widget.component.css']
})
export class DashboardWidgetComponent implements OnInit {
  @Input() board: BoardItem;
  stacks: BehaviorSubject<StackItem[]> = new BehaviorSubject<StackItem[]>(null)
  stacksLoading = true;

  constructor(private stackService: StackService) { }

  ngOnInit(): void {
    this.getStacks()
  }

  getStacks() {
    if (!this.board) return
    return this.stackService.getStacks(this.board.id).toPromise().then(value => {
      this.stacks.next(value);
    }).finally(() =>
      this.stacksLoading = false
    );
  }
}
