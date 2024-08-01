import 'dart:convert';

class ChapterDataResponse {
  String result;
  String baseUrl;
  Chapter chapter;

  ChapterDataResponse({
    required this.result,
    required this.baseUrl,
    required this.chapter,
  });

  factory ChapterDataResponse.fromRawJson(String str) =>
      ChapterDataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChapterDataResponse.fromJson(Map<String, dynamic> json) =>
      ChapterDataResponse(
        result: json["result"],
        baseUrl: json["baseUrl"],
        chapter: Chapter.fromJson(json["chapter"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "baseUrl": baseUrl,
        "chapter": chapter.toJson(),
      };
}

class Chapter {
  String hash;
  List<String> data;
  List<String> dataSaver;

  Chapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });

  factory Chapter.fromRawJson(String str) => Chapter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        hash: json["hash"],
        data: List<String>.from(json["data"].map((x) => x)),
        dataSaver: List<String>.from(json["dataSaver"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "data": List<dynamic>.from(data.map((x) => x)),
        "dataSaver": List<dynamic>.from(dataSaver.map((x) => x)),
      };
}
