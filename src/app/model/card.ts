import { Label } from './label';
import { Attachement } from "@app/model/attachement";
import { Assignment } from "@app/model/assignment";
import { User } from "@app/model/user";
import { Board } from "@app/model/board";
import { Stack } from "@app/model/stack";


export class Card {
    title: string;
    description?: string;
    descriptionPrev?: string
    stackId?: number;
    type?: string;
    lastModified?: number;
    lastEditor?: string
    createdAt?: number;
    labels?: Array<Label>;
    assignedUsers?: Array<Assignment>;
    attachments?: Array<Attachement>;
    attachmentCount?: number;
    owner?: User;
    order?: number;
    archived?: boolean;
    duedate?: string;
    deletedAt?: number;
    commentsUnread?: number;
    commentsCount?: number;
    id?: number;
    overdue?: number;
    ETag: string
    notified?: boolean
    relatedBoard?: Board
    relatedStack?: Stack

}

