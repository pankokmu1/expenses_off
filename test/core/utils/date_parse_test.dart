import 'package:expenses_off/core/utils/date_parse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Date parse utils =>', () {
    test('convert String to DateTime with zone', () {
      final result = stringToDateAndTimeZone("2023-09-23 13:58:00.123Z");

      expect(result, DateTime.utc(2023, 09, 23, 13, 58, 0, 123));
    });
    test('convert DateTime with zone to String', () {
      final result =
          dateTimeToStringWithZone(DateTime.utc(2023, 09, 23, 13, 58, 0, 123));

      expect(result, "2023-09-23 13:58:00.123Z");
    });
  });
}
