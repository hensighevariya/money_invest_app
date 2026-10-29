/// Reads an id that the API may send as a string or a populated document.
String? readApiId(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
  if (value is Map) {
    return readApiId(value['_id'] ?? value['id'] ?? value[r'$oid']);
  }
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

/// First non-null value among renamed API keys.
dynamic readApiAlias(Map<dynamic, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value != null) return value;
  }
  return null;
}
