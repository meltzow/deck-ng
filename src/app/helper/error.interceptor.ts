import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor, HttpErrorResponse } from '@angular/common/http';
import { Observable, of, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

import { AuthenticationService } from '@app/services';
import { NotificationService } from "@app/services/notification.service";

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {
  constructor(
    private authenticationService: AuthenticationService,
    private notification: NotificationService
  ) { }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    let error
    return next.handle(request).pipe(catchError( (err: HttpErrorResponse) => {
      switch (err.status) {
        case 401:
          this.authenticationService.logout();
          break
        case 404:
          this.authenticationService.logout();
          this.notification.error("server url not found", "Request not successful")
          break
        case 0:
          this.authenticationService.logout();
          this.notification.error("check username and password", "Request not successful")
          break
        default:
          error = err.error.message || err.statusText;
          this.notification.error(error, "Request not successful")
          return throwError(error);
      }
    })
    );
  }
}
