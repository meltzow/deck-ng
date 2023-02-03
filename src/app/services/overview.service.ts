import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

import { Capabilities, Upcoming, Ocs, Board } from '@app/model';

import { HttpService } from "@app/services/http.service";


@Injectable({
  providedIn: 'root'
})
export class OverviewService {

  nextCloudVersion = new BehaviorSubject<string>(null)
  deckVersion = new BehaviorSubject<string>(null)
  currentUpcomingsSubj: BehaviorSubject<Upcoming[]> = new BehaviorSubject<Upcoming[]>([])
  constructor(protected httpService: HttpService) {
  }

  public async upcoming(): Promise<Upcoming[]> {
    const ups = await this.httpService.get<Ocs>('ocs/v2.php/apps/deck/api/v1.0/overview/upcoming')
    this.currentUpcomingsSubj.next(ups.ocs.data)
    return ups.ocs.data
  }

  public getAssigneesNames(upcoming: Upcoming): string[] {
    return upcoming.assignedUsers?.map(value => value.participant.displayname)
  }

  public async getCapabilities(): Promise<Capabilities> {
    const prom = await this.httpService.get<Capabilities>('ocs/v1.php/cloud/capabilities')
    this.nextCloudVersion.next(prom.ocs.data.version.string)
    this.deckVersion.next(prom.ocs.data.capabilities.deck.version)
    return prom
  }
}
