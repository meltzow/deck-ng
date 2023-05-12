import { Label } from './label';
import { BoardPermissions } from './boardPermissions';
import { BoardSettings } from './boardSettings';
import { User } from "@app/model/user";


export class Board {

    constructor(public id?: number) {
    }
    title: string;
    owner?: User;
    color?: string;
    archived?: boolean;
    labels?: Array<Label>;
    acl?: Array<string>;
    permissions?: BoardPermissions;
    users?: Array<User>;
    shared?: number;
    deletedAt?: number;
    lastModified?: number;
    settings?: BoardSettings;
}

