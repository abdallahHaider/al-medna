String formatPrice(dynamic value) {
  if (value is int) {
    return value.toString();
  } else if (value is double) {
    return value.toStringAsFixed(2);
  } else {
    throw Exception('Unexpected value type');
  }
}
