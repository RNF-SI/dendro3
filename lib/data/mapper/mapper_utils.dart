T? logAndReturnNull<T>(String key, {String? customMessage}) {
  final message = customMessage ?? "Key '$key' not found or is null";
  print(message);
  return null;
}
