import { Card } from "@app/model/card";

export class UpcomingResponse {
  ocs : {
    meta: {
      "status": string,
      "statuscode": number,
      "message": string
    },
    data: Card[]
  }
}
