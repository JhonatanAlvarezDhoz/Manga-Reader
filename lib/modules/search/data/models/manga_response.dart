import 'dart:convert';

class MangaResponse {
  String result;
  String response;
  List<Manga> data;
  int limit;
  int offset;
  int total;

  MangaResponse({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  // Constructor para un objeto vacío
  factory MangaResponse.empty() {
    return MangaResponse(
      result: '',
      response: '',
      data: [],
      limit: 0,
      offset: 0,
      total: 0,
    );
  }

  factory MangaResponse.fromRawJson(String str) =>
      MangaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MangaResponse.fromJson(Map<String, dynamic> json) => MangaResponse(
        result: json["result"],
        response: json["response"],
        data: List<Manga>.from(json["data"].map((x) => Manga.fromJson(x))),
        limit: json["limit"],
        offset: json["offset"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "data": List<Manga>.from(data.map((x) => x.toJson())),
        "limit": limit,
        "offset": offset,
        "total": total,
      };
}

class Manga {
  String id;
  String type;
  MangaAttributes attributes;

  Manga({
    required this.id,
    required this.type,
    required this.attributes,
  });

  // Constructor para un objeto vacío
  factory Manga.empty() {
    return Manga(
      id: '',
      type: '',
      attributes: MangaAttributes.empty(),
    );
  }

  factory Manga.fromRawJson(String str) => Manga.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
        id: json["id"],
        type: json["type"],
        attributes: MangaAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class MangaAttributes {
  Title title;
  PurpleDescription description;
  bool isLocked;
  Links links;
  String? originalLanguage;
  String? lastVolume;
  String? lastChapter;
  String? publicationDemographic;
  String? status;
  int? year;
  String? contentRating;
  String? state;
  bool? chapterNumbersResetOnNewVolume;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;
  List<String>? availableTranslatedLanguages;
  String? latestUploadedChapter;

  MangaAttributes({
    required this.title,
    required this.description,
    required this.isLocked,
    required this.links,
    this.originalLanguage,
    this.lastVolume,
    this.lastChapter,
    this.publicationDemographic,
    this.status,
    this.year,
    this.contentRating,
    this.state,
    this.chapterNumbersResetOnNewVolume,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.availableTranslatedLanguages,
    this.latestUploadedChapter,
  });

  // Constructor para un objeto vacío
  factory MangaAttributes.empty() {
    return MangaAttributes(
      title: Title.empty(),
      description: PurpleDescription.empty(),
      isLocked: false,
      links: Links.empty(),
    );
  }

  factory MangaAttributes.fromJson(Map<String, dynamic> json) =>
      MangaAttributes(
        title: Title.fromJson(json["title"] ?? {}),
        description: PurpleDescription.fromJson(json["description"] ?? {}),
        isLocked: json["isLocked"] ?? false,
        links: Links.fromJson(json["links"] ?? {}),
        originalLanguage: json["originalLanguage"],
        lastVolume: json["lastVolume"],
        lastChapter: json["lastChapter"],
        publicationDemographic: json["publicationDemographic"],
        status: json["status"],
        year: json["year"],
        contentRating: json["contentRating"],
        state: json["state"],
        chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        version: json["version"],
        availableTranslatedLanguages:
            json["availableTranslatedLanguages"] != null
                ? List<String>.from(
                    json["availableTranslatedLanguages"].map((x) => x))
                : null,
        latestUploadedChapter: json["latestUploadedChapter"],
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "description": description.toJson(),
        "isLocked": isLocked,
        "links": links.toJson(),
        "originalLanguage": originalLanguage,
        "lastVolume": lastVolume,
        "lastChapter": lastChapter,
        "publicationDemographic": publicationDemographic,
        "status": status,
        "year": year,
        "contentRating": contentRating,
        "state": state,
        "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "version": version,
        "availableTranslatedLanguages": availableTranslatedLanguages != null
            ? List<dynamic>.from(availableTranslatedLanguages!.map((x) => x))
            : null,
        "latestUploadedChapter": latestUploadedChapter,
      };
}

class PurpleDescription {
  String? es;
  String? en;

  PurpleDescription({
    this.es,
    this.en,
  });

  // Constructor para un objeto vacío
  factory PurpleDescription.empty() {
    return PurpleDescription(
      es: null,
      en: null,
    );
  }

  factory PurpleDescription.fromRawJson(String str) =>
      PurpleDescription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PurpleDescription.fromJson(Map<String, dynamic> json) =>
      PurpleDescription(
        es: json["es"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "es": es,
        "en": en,
      };
}

class Links {
  String? al;
  String? ap;
  String? bw;
  String? kt;
  String? mu;
  String? amz;
  String? cdj;
  String? ebj;
  String? mal;
  String? raw;
  String? engtl;

  Links({
    this.al,
    this.ap,
    this.bw,
    this.kt,
    this.mu,
    this.amz,
    this.cdj,
    this.ebj,
    this.mal,
    this.raw,
    this.engtl,
  });

  // Constructor para un objeto vacío
  factory Links.empty() {
    return Links(
      al: null,
      ap: null,
      bw: null,
      kt: null,
      mu: null,
      amz: null,
      cdj: null,
      ebj: null,
      mal: null,
      raw: null,
      engtl: null,
    );
  }

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        al: json["al"],
        ap: json["ap"],
        bw: json["bw"],
        kt: json["kt"],
        mu: json["mu"],
        amz: json["amz"],
        cdj: json["cdj"],
        ebj: json["ebj"],
        mal: json["mal"],
        raw: json["raw"],
        engtl: json["engtl"],
      );

  Map<String, dynamic> toJson() => {
        "al": al,
        "ap": ap,
        "bw": bw,
        "kt": kt,
        "mu": mu,
        "amz": amz,
        "cdj": cdj,
        "ebj": ebj,
        "mal": mal,
        "raw": raw,
        "engtl": engtl,
      };
}

class Title {
  String? en;
  String? es;

  Title({
    this.en,
    this.es,
  });

  // Constructor para un objeto vacío
  factory Title.empty() {
    return Title(
      en: null,
      es: null,
    );
  }

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        en: json["en"],
        es: json["es"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "es": es,
      };
}

// Uso del constructor vacío
Manga mangaVacio = Manga.empty();
MangaResponse mangaResponseVacio = MangaResponse.empty();
