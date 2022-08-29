import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot } from '@angular/router';
import { AuthenticationService } from '@app/services/authentication.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    public authenticationService: AuthenticationService,
    private router: Router,

  ) {
  }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
    if (this.authenticationService.isAuthenticated()) {
      return true
    }
    // not logged in so redirect to login page with the return url and return false
    this.router.navigate(['login'], { queryParams: { returnUrl: state.url }});
    return false;
  }
}
