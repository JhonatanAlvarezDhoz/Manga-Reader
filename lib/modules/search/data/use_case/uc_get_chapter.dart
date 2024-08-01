import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:manga_reader/base/use_case/base_use_case.dart';
import 'package:manga_reader/modules/search/data/models/chapter_data_response.dart';
import 'package:manga_reader/modules/search/data/repository/r_search.dart';

class GetChapterUseCaseParams extends UseCaseParams {
  final String chapterId;

  GetChapterUseCaseParams(this.chapterId);
}

class GetChapterUseCase
    extends UseCase<ChapterDataResponse, GetChapterUseCaseParams> {
  final SearchRepository repository;

  GetChapterUseCase({required this.repository});

  @override
  Future<ChapterDataResponse> call({GetChapterUseCaseParams? params}) async {
    http.Response response =
        await repository.getChapterContents(params!.chapterId);

    switch (response.statusCode) {
      case 200:
        ChapterDataResponse chapter = ChapterDataResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        return chapter;
      default:
        throw UseCaseException("Hubo un error al cargar el capitulo");
    }
  }
}
