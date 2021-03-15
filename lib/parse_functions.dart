library parse_functions;

typedef ParseEntityFunction<T> = T Function(dynamic value);

double parseDouble(dynamic value, double defaultValue) =>
    double.tryParse('$value') ?? defaultValue;

int parseInt(dynamic value, int defaultValue) =>
    int.tryParse('$value') ?? defaultValue;

num parseNum(dynamic value, num defaultValue) =>
    num.tryParse('$value') ?? defaultValue;

String parseString(dynamic value, String defaultValue) {
  if (value == null) {
    return defaultValue;
  } else {
    return '$value';
  }
}

bool parseBool(dynamic value, bool defaultValue) {
  if ('$value'.toLowerCase() == 'true') {
    return true;
  } else if ('$value'.toLowerCase() == 'false') {
    return false;
  } else {
    return defaultValue;
  }
}

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

UriData parseUriData(dynamic value, UriData defaultValue) {
  try {
    return UriData.parse('$value');
  } on FormatException {
    return defaultValue;
  }
}

Uri parseUri(dynamic value, Uri defaultValue, [int start = 0, int end]) {
  if (value == null) {
    return defaultValue;
  } else {
    return Uri.tryParse('$value', start, end) ?? defaultValue;
  }
}

BigInt parseBigInt(dynamic value, BigInt defaultValue, {int radix}) =>
    BigInt.tryParse('$value', radix: radix) ?? defaultValue;

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
