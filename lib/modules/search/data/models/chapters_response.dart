// ignore_for_file: constant_identifier_names

import 'dart:convert';

class ChaptersResponse {
  String result;
  String response;
  List<Chapters> data;
  int limit;
  int offset;
  int total;

  ChaptersResponse({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory ChaptersResponse.fromRawJson(String str) =>
      ChaptersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChaptersResponse.fromJson(Map<String, dynamic> json) =>
      ChaptersResponse(
        result: json["result"],
        response: json["response"],
        data:
            List<Chapters>.from(json["data"].map((x) => Chapters.fromJson(x))),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}

class Chapters {
  String id;
  DatumType type;
  ChapterAttributes attributes;

  Chapters({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory Chapters.fromRawJson(String str) =>
      Chapters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
        id: json["id"],
        type: datumTypeValues.map[json["type"]]!,
        attributes: ChapterAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": datumTypeValues.reverse[type],
        "attributes": attributes.toJson(),
      };
}

class ChapterAttributes {
  String? volume;
  String? chapter;
  String? title;
  TranslatedLanguage? translatedLanguage;
  dynamic externalUrl;
  DateTime? publishAt;
  DateTime? readableAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? pages;
  int? version;

  ChapterAttributes({
    required this.volume,
    required this.chapter,
    required this.title,
    required this.translatedLanguage,
    required this.externalUrl,
    required this.publishAt,
    required this.readableAt,
    required this.createdAt,
    required this.updatedAt,
    required this.pages,
    required this.version,
  });

  factory ChapterAttributes.fromRawJson(String str) =>
      ChapterAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      ChapterAttributes(
        volume: json["volume"],
        chapter: json["chapter"],
        title: json["title"],
        translatedLanguage:
            translatedLanguageValues.map[json["translatedLanguage"]]!,
        externalUrl: json["externalUrl"],
        publishAt: DateTime.parse(json["publishAt"]),
        readableAt: DateTime.parse(json["readableAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        pages: json["pages"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "volume": volume,
        "chapter": chapter,
        "title": title,
        "translatedLanguage":
            translatedLanguageValues.reverse[translatedLanguage],
        "externalUrl": externalUrl,
        "publishAt": publishAt?.toIso8601String(),
        "readableAt": readableAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "pages": pages,
        "version": version,
      };
}

enum TranslatedLanguage { ES_LA }

enum DatumType { CHAPTER }

final translatedLanguageValues =
    EnumValues({"es-la": TranslatedLanguage.ES_LA});

final datumTypeValues = EnumValues({"chapter": DatumType.CHAPTER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
