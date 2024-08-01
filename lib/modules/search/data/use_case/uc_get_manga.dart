import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:manga_reader/base/use_case/base_use_case.dart';
import 'package:manga_reader/modules/search/data/models/chapters_response.dart';
import 'package:manga_reader/modules/search/data/repository/r_search.dart';

class GetMangaUseCaseParams extends UseCaseParams {
  final String mangaId;
  final int offset;
  final String order;

  GetMangaUseCaseParams({
    required this.mangaId,
    this.offset = 0,
    this.order = 'asc',
  });
}

class GetMangaUseCase extends UseCase<ChaptersResponse, GetMangaUseCaseParams> {
  final SearchRepository repository;

  GetMangaUseCase({required this.repository});
  @override
  Future<ChaptersResponse> call({GetMangaUseCaseParams? params}) async {
    http.Response response = await repository.getManga(
      params!.mangaId,
      params.offset,
      params.order,
    );

    switch (response.statusCode) {
      case 200:
        ChaptersResponse manga = ChaptersResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        return manga;
      default:
        throw UseCaseException("Hubo un error al cargar el manga");
    }
  }
}
