import { Component, Input, OnInit } from '@angular/core';
import { StackItem } from "@app/model/stackItem";

@Component({
  selector: 'app-stack-preview',
  templateUrl: './stack-preview.component.html',
  styleUrls: ['./stack-preview.component.css']
})
export class StackPreviewComponent implements OnInit {

  @Input() stack: StackItem;

  constructor() {
  }

  ngOnInit(): void {
  }

}
