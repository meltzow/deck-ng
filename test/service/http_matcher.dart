import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

/// [FullHttpRequestMatcher] is the default matcher and matches the entire URL
/// signature including headers, request body, query parameters etc.
///
class FullHttpRequestDataMatcher extends HttpRequestMatcher {
  const FullHttpRequestDataMatcher();

  @override
  bool matches(RequestOptions ongoingRequest, Request matcher) {
    final isTheSameHeaders =
        ongoingRequest.matches(ongoingRequest.headers, matcher.headers);
    final isTheSameData =
        ongoingRequest.matches(ongoingRequest.data, matcher.data);
    final isTheSameRoute =
        ongoingRequest.doesRouteMatch(ongoingRequest.path, matcher.route);
    return isTheSameHeaders &&
        isTheSameData &&
        isTheSameRoute &&
        (ongoingRequest.method.toLowerCase() ==
            matcher.method?.name.toLowerCase());
  }
}
