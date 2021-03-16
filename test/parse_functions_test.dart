import 'package:test/test.dart';

import 'package:parse_functions/parse_functions.dart';

void main() {
  group('parse double', () {
    test('null', () {
      expect(parseDouble(null, 2.0), 2.0);
    });

    test('normal value', () {
      expect(parseDouble(3.0, 2.0), 3.0);
    });

    test('garbage value', () {
      expect(parseDouble(DateTime(2000), 2.0), 2.0);
    });
  });

  group('parse int', () {
    test('null', () {
      expect(parseInt(null, 2), 2);
    });

    test('normal value', () {
      expect(parseInt(3, 2), 3);
    });

    test('garbage value', () {
      expect(parseInt(DateTime(2000), 2), 2);
    });
  });

  group('parse num', () {
    test('null', () {
      expect(parseNum(null, 2), 2);
    });

    test('normal value', () {
      expect(parseNum(3, 2), 3);
    });

    test('garbage value', () {
      expect(parseNum(DateTime(2000), 2), 2);
    });
  });
  group('parse String', () {
    test('null', () {
      expect(parseString(null, 'test'), 'test');
    });

    test('normal value', () {
      expect(parseString('test1', 'test'), 'test1');
    });
  });

  group('parse bool', () {
    test('null', () {
      expect(parseBool(null, true), true);
    });

    test('normal value', () {
      expect(parseBool(false, true), false);
    });

    test('string normal value', () {
      expect(parseBool('False', true), false);
    });

    test('garbage value', () {
      expect(parseBool(DateTime(2000), true), true);
    });
  });

  group('parse DateTime', () {
    test('null', () {
      expect(parseDateTime(null, DateTime(2000)), DateTime(2000));
    });

    test('normal String value', () {
      expect(parseDateTime('2100-01-01 00:00:00.000', DateTime(2000)),
          DateTime(2100));
    });

    test('normal timestamp value', () {
      expect(parseDateTime(4102434000000, DateTime(2000)), DateTime(2100));
    });

    test('normal String timestamp value', () {
      expect(parseDateTime('4102434000000', DateTime(2000)), DateTime(2100));
    });

    test('normal String unix timestamp value', () {
      expect(
          parseDateTime('4102434000', DateTime(2000), isSecondsFromEpoch: true),
          DateTime(2100));
    });

    test('garbage value', () {
      expect(parseDateTime('test', DateTime(2000)), DateTime(2000));
    });
  });

  group('parse UriData', () {
    test('null', () {
      final uriData = UriData.parse('data:,A%20brief%20note');
      expect(parseUriData(null, uriData), uriData);
    });

    test('normal value', () {
      expect(
          parseUriData('data:,Another%20brief%20note',
                  UriData.parse('data:,A%20brief%20note'))
              .toString(),
          equals(UriData.parse('data:,Another%20brief%20note').toString()));
    });

    test('garbage value', () {
      final uriData = UriData.parse('data:,A%20brief%20note');
      expect(parseUriData(DateTime(2000), uriData), uriData);
    });
  });

  group('parse Uri', () {
    test('null', () {
      final uri = Uri.parse('https://www.wikipedia.org');
      expect(parseUri(null, uri), uri);
    });

    test('normal value', () {
      expect(
          parseUri('https://www.wikipedia.org',
              Uri.parse('https://www.google.com/')),
          Uri.parse('https://www.wikipedia.org'));
    });

    test('garbage value', () {
      final uri = Uri.parse('https://www.wikipedia.org');
      expect(parseUri(DateTime(2000), uri), uri);
    });
  });

  group('parse BigInt', () {
    test('null', () {
      final bigInt = BigInt.from(1000);
      expect(parseBigInt(null, bigInt), bigInt);
    });

    test('normal value', () {
      expect(parseBigInt('0x7d0', BigInt.from(1000)), BigInt.parse('0x7d0'));
    });

    test('garbage value', () {
      final bigInt = BigInt.from(1000);
      expect(parseBigInt(DateTime(2000), bigInt), bigInt);
    });
  });

  group('parse List', () {
    test('null', () {
      expect(
          parseList<String>(null, (value) => parseString(value, ''),
              defaultValue: ['test']),
          ['test']);
    });

    test('normal value', () {
      expect(
          parseList<String>(
              [123, 1234, 12345], (value) => parseString(value, '')),
          ['123', '1234', '12345']);
    });

    test('garbage value', () {
      expect(parseList<int>(['a', 'b', 'c', 4], (value) => int.parse('$value')),
          [4]);
    });
  });

  group('parse ListNoCatch', () {
    test('null', () {
      expect(
          parseListNoCatch<String>(null, (value) => parseString(value, ''),
              defaultValue: ['test']),
          ['test']);
    });

    test('normal value', () {
      expect(
          parseListNoCatch<String>(
              [123, 1234, 12345], (value) => parseString(value, '')),
          ['123', '1234', '12345']);
    });

    test('garbage value', () {
      expect(
          parseListNoCatch<int>(
              ['a', 'b', 'c', 4], (value) => parseInt(value, 0)),
          [0, 0, 0, 4]);
    });
  });
}
