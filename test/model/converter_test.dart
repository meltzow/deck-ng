import 'package:deck_ng/model/converter.dart';
import 'package:test/test.dart';

void main() {
  test('correct Date from nextcloud json int', () {
    var date = DateTime(2024, 03, 11, 19, 58, 02);
    var json = date.millisecondsSinceEpoch ~/ 1000;
    var dateTime = const EpochDateTimeConverter().fromJson(json);

    expect(dateTime, date);
  });

  test('correct nextcloud int from date ', () {
    var date = DateTime(2024, 03, 11, 19, 58, 02);
    var intvalue = const EpochDateTimeConverter().toJson(date);

    expect(intvalue, date.millisecondsSinceEpoch ~/ 1000);
  });
}
