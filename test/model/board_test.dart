import 'package:deck_ng/model/board.dart';
import 'package:test/test.dart';

void main() {
  test('without labels', () {
    var json = {'title': "foo title", 'id': 1};
    var board = Board.fromJson(json);

    expect(board.title, "foo title");
  });
}
