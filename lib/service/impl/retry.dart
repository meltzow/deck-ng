/// Retry asynchronous functions with exponential backoff.
///
/// For a simple solution see [retry], to modify and persist retry options see
/// [RetryOptions]. Note, in many cases the added configurability is
/// unnecessary and using [retry] is perfectly fine.
library retry;

import 'dart:async';

final class RetryOptions {
  static const String retryHeader = 'servercalls';
  final Duration delayFactor;

  /// Maximum delay between retries, defaults to 30 seconds.
  final Duration maxDelay;

  /// Maximum number of attempts before giving up, defaults to 8.
  final int maxAttempts;

  /// Create a set of [RetryOptions].
  const RetryOptions({
    this.delayFactor = const Duration(milliseconds: 200),
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 8,
  });

  /// Delay after [attempt] number of attempts.
  ///
  /// This is computed as `pow(2, attempt) * delayFactor`, then is multiplied by
  /// between `-randomizationFactor` and `randomizationFactor` at random.
  Duration delay(int attempt) {
    assert(attempt >= 0, 'attempt cannot be negative');
    if (attempt <= 0) {
      return Duration.zero;
    }
    final delay = delayFactor;
    return delay < maxDelay ? delay : maxDelay;
  }

  /// Call [fn] retrying so long as [retryIf] return `true` for the exception
  /// thrown.
  ///
  /// At every retry the [onRetry] function will be called (if given). The
  /// function [fn] will be invoked at-most [this.attempts] times.
  ///
  /// If no [retryIf] function is given this will retry any for any [Exception]
  /// thrown. To retry on an [Error], the error must be caught and _rethrown_
  /// as an [Exception].
  Future<T> retry<T>(
    FutureOr<T> Function() fn, {
    FutureOr<bool> Function(Exception)? retryIf,
    FutureOr<void> Function(Exception)? onRetry,
  }) async {
    var attempt = 0;
    // ignore: literal_only_boolean_expressions
    while (true) {
      attempt++; // first invocation is the first attempt
      try {
        return await fn();
      } on Exception catch (e) {
        if (attempt >= maxAttempts ||
            (retryIf != null && !(await retryIf(e)))) {
          rethrow;
        }
        if (onRetry != null) {
          await onRetry(e);
        }
      }

      // Sleep for a delay
      await Future.delayed(delay(attempt));
    }
  }
}
