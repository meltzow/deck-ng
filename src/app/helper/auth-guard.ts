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

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Promise<boolean> {
    return this.authenticationService.isAuthenticated().then(value => {
      if (value) {
        return Promise.resolve(true)
    } else {
        // not logged in so redirect to login page with the return url and return false
        this.router.navigate(['auth'], { queryParams: { returnUrl: state.url }});
        return Promise.resolve(false)
      }
  }).catch(reason =>
      // not logged in so redirect to login page with the return url and return false
      this.router.navigate(['auth'], { queryParams: { returnUrl: state.url }})
    )
  }
}
