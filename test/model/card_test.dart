import 'package:deck_ng/model/card.dart';
import 'package:test/test.dart';

void main() {
  test('to json without owner', () {
    var card = Card(title: "foo title", id: 1);
    var json = card.toJson();

    expect(json['title'], "foo title");
  });
}
