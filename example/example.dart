import 'package:parse_functions/parse_functions.dart';

void main() async {
  ///double parsing
  parseDouble(null, 2.0);

  ///int parsing
  parseInt(null, 2);

  ///num parsing
  parseNum(null, 2);

  ///String parsing
  parseString(null, 'test');

  ///bool parsing
  parseBool(null, true);

  ///DateTime parsing
  parseDateTime(null, DateTime(2000));

  ///UriData parsing
  final uriData = UriData.parse('data:,A%20brief%20note');
  parseUriData(null, uriData);

  ///Uri parsing
  final uri = Uri.parse('https://www.wikipedia.org');
  parseUri(null, uri);

  ///BigInt parsing
  final bigInt = BigInt.from(1000);
  parseBigInt(null, bigInt);

  ///List parsing
  parseList<String>(null, (value) => parseString(value, ''),
      defaultValue: ['test']);

  ///ListNoCatch parsing
  parseListNoCatch<String>(null, (value) => parseString(value, ''),
      defaultValue: ['test']);
}
