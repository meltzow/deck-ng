import { Label } from './label';
import { Attachement } from "@app/model/attachement";
import { Assignment } from "@app/model/assignment";
import { User } from "@app/model/user";
import { Board } from "@app/model/board";
import { Stack } from "@app/model/stack";


export class Card {

  ETag?: string
  archived?: boolean
  assignedUsers?: Array<Assignment>
  attachmentCount?: number
  attachments?: Array<Attachement>
  commentsCount?: number;
  commentsUnread?: number;
  createdAt?: number
  deletedAt?: number
  description?: string
  duedate?: string
  id?: number
  labels?: Array<Label>
  lastEditor?: string
  lastModified?: number
  order?: number
  overdue?: number
  owner?: User
  stackId?: number
  title: string
  type?: string

}

