class SearchResult {
  final bool cancel;

  SearchResult({
    this.cancel = false,
  });

  @override
  String toString() {
    return "{Cancel: $cancel}";
  }
}
