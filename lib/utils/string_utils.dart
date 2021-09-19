extension StringExtension on String {
  String capitalize() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
    return this;
  }
}