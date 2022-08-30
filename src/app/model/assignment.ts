import { User } from "@app/model/user";

export interface Assignment {
    cardId: number;
    id: number;
    participant: User;
    type: number
}

