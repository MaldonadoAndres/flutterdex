extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  String get capitalize =>
      isNullOrEmpty ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';
}
