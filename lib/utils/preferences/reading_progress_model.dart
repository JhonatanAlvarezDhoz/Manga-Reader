class ReadingProgress {
  final String mangaId;
  final String chapterId;

  ReadingProgress({required this.mangaId, required this.chapterId});

  Map<String, dynamic> toJson() => {
        'mangaId': mangaId,
        'chapterId': chapterId,
      };

  factory ReadingProgress.fromJson(Map<String, dynamic> json) {
    return ReadingProgress(
      mangaId: json['mangaId'],
      chapterId: json['chapterId'],
    );
  }
}
