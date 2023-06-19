import 'package:dio/src/options.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class AnyHttpMatcher extends HttpRequestMatcher {
  @override
  bool matches(RequestOptions ongoingRequest, Request matcher) {
    // TODO: implement matches
    throw true;
  }
}
