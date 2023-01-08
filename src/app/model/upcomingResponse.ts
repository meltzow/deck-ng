import { Card } from "@app/model/card";
import { Upcoming } from "@app/model/upcoming";

export class UpcomingResponse {
  ocs : {
    meta: {
      "status": string,
      "statuscode": number,
      "message": string
    },
    data: Upcoming[]
  }
}
