String? findBetween(String start, String end, String input) {
  final startIndex = input.indexOf(start);
  if (startIndex == -1) {
    return null;
  }
  
  final endIndex = input.indexOf(end, startIndex + start.length);
  if (endIndex == -1) {
    return null;
  }
  
  return input.substring(startIndex + start.length, endIndex);
}


String substringAfter(String source, String delimiter) {
  final index = source.indexOf(delimiter);
  if (index == -1) {
    return "";
  }
  return source.substring(index + delimiter.length);
}