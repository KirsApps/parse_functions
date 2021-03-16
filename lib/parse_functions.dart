library parse_functions;

typedef ParseEntityFunction<T> = T Function(dynamic value);

/// Returns parsed [double] value if [value] can be parsed by [double.tryParse],
/// in another case returns [defaultValue]
double parseDouble(dynamic value, double defaultValue) =>
    double.tryParse('$value') ?? defaultValue;

/// Returns parsed [int] value if [value] can be parsed by [int.tryParse],
/// in another case returns [defaultValue]
int parseInt(dynamic value, int defaultValue) =>
    int.tryParse('$value') ?? defaultValue;

/// Returns parsed [num] value if [value] can be parsed by [num.tryParse],
/// in another case returns [defaultValue]
num parseNum(dynamic value, num defaultValue) =>
    num.tryParse('$value') ?? defaultValue;

/// Returns parsed [String] from [value], if [value] is not null,
/// in another case returns [defaultValue]
String parseString(dynamic value, String defaultValue) {
  if (value == null) {
    return defaultValue;
  } else {
    return '$value';
  }
}

/// Returns parsed [bool] from [value], if [value] can't be parsed returns [defaultValue]
bool parseBool(dynamic value, bool defaultValue) {
  if ('$value'.toLowerCase() == 'true') {
    return true;
  } else if ('$value'.toLowerCase() == 'false') {
    return false;
  } else {
    return defaultValue;
  }
}

/// Returns parsed [DateTime] from [value], the [value] can be a timestamp or a string.
///
/// Examples
/// ```dart
/// parseDateTime('4102434000000', DateTime(2000);
/// ```
/// ```dart
/// parseDateTime('2100-01-01 00:00:00.000', DateTime(2000);
/// ```
DateTime parseDateTime(dynamic value, DateTime defaultValue,
    {bool isSecondsFromEpoch = false}) {
  final timestamp = int.tryParse('$value');
  if (timestamp != null) {
    return DateTime.fromMillisecondsSinceEpoch(
        isSecondsFromEpoch ? timestamp * 1000 : timestamp);
  } else {
    return DateTime.tryParse('$value') ?? defaultValue;
  }
}

/// Returns parsed [UriData] from [value], if [value] is not a valid data URI,
/// returns [defaultValue]
UriData parseUriData(dynamic value, UriData defaultValue) {
  try {
    return UriData.parse('$value');
  } on FormatException {
    return defaultValue;
  }
}

/// Returns parsed [Uri] from [value], if [value] is not a valid URI,
/// returns [defaultValue]
Uri parseUri(dynamic value, Uri defaultValue, [int start = 0, int end]) {
  if (value == null) {
    return defaultValue;
  } else {
    return Uri.tryParse('$value', start, end) ?? defaultValue;
  }
}

/// Returns parsed [BigInt] value if [value] can be parsed by [BigInt.tryParse],
/// in another case returns [defaultValue]
BigInt parseBigInt(dynamic value, BigInt defaultValue, {int radix}) =>
    BigInt.tryParse('$value', radix: radix) ?? defaultValue;

/// Returns parsed [List] from [value].
///
/// if value is [Iterable] every [value] element will be passed to [parseFunction],
/// which must return parsed <T> value, if [parseFunction] throws an error,
/// current element will be skipped.
/// if value is not Iterable or if [list] result is empty returns [defaultValue]
List<T> parseList<T>(dynamic value, ParseEntityFunction<T> parseFunction,
    {List<T> defaultValue = const []}) {
  if (value is Iterable) {
    var list = <T>[];
    for (final entity in value) {
      try {
        list.add(parseFunction(entity));
      } catch (_) {
        continue;
      }
    }
    return list.isEmpty ? defaultValue : list;
  } else {
    return defaultValue;
  }
}

/// Returns parsed [List] from [value].
///
/// if value is [Iterable] every [value] element will be passed to [parseFunction],
/// which must return parsed <T> value, if [parseFunction] throws an error,
/// execution will be terminated.
/// if value is not Iterable or if [list] result is empty returns [defaultValue]
List<T> parseListNoCatch<T>(dynamic value, ParseEntityFunction<T> parseFunction,
    {List<T> defaultValue = const []}) {
  if (value is Iterable) {
    var list = <T>[];
    for (final entity in value) {
      list.add(parseFunction(entity));
    }
    return list.isEmpty ? defaultValue : list;
  } else {
    return defaultValue;
  }
}
