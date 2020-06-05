class UnsupportedOSException implements Exception {
  String _os;

  String get os => _os;

  UnsupportedOSException(this._os);
}
