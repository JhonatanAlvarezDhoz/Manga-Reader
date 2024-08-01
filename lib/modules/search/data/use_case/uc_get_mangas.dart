import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:manga_reader/base/use_case/base_use_case.dart';
import 'package:manga_reader/modules/search/data/models/manga_response.dart';
import 'package:manga_reader/modules/search/data/repository/r_search.dart';

class GetMangasUseCaseParams extends UseCaseParams {
  final String query;
  GetMangasUseCaseParams(this.query);
}

class GetMangasUseCase extends UseCase<MangaResponse, GetMangasUseCaseParams> {
  final SearchRepository repository;

  GetMangasUseCase({required this.repository});

  @override
  Future<MangaResponse> call({GetMangasUseCaseParams? params}) async {
    http.Response response = await repository.getMangas(params!.query);

    switch (response.statusCode) {
      case 200:
        MangaResponse mangaresult = MangaResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        return mangaresult;
      default:
        throw UseCaseException(
          "Ha ocurrido un error y no se pudo cargar la lista de mangas relacionados.",
        );
    }
  }
}
