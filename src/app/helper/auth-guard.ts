import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { AuthenticationService } from '@app/services/authentication.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    public authenticationService: AuthenticationService
  ) {
  }

  canActivate(): boolean {
    return this.authenticationService.isAuthenticated();
  }
}
