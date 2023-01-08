import { Injectable } from '@angular/core';
import { HttpClient, } from '@angular/common/http';
import { BehaviorSubject } from 'rxjs';

import { Upcoming, UpcomingResponse } from '@app/model';

import { AuthenticationService } from "@app/services/authentication.service";
import { ServiceHelper } from "@app/helper/serviceHelper"
import { HttpService } from "@app/services/http.service";


@Injectable({
  providedIn: 'root'
})
export class OverviewService {
  currentUpcomingsSubj = new BehaviorSubject<UpcomingResponse>(new UpcomingResponse())

  constructor(protected httpService: HttpService) {
  }


  /**
   * Get a list of boards
   *
   */
  public async upcoming(): Promise<UpcomingResponse> {
     return this.httpService.get<UpcomingResponse>('ocs/v2.php/apps/deck/api/v1.0/overview/upcoming')
  }

  public get currentUpcomings(): BehaviorSubject<UpcomingResponse> {
    return this.currentUpcomingsSubj
  }

  public getAssigneesNames(upcoming: Upcoming): string[] {
    return upcoming.assignedUsers?.map(value => value.participant.displayname)
  }

}
