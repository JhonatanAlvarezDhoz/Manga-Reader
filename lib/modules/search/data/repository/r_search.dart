import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:manga_reader/base/repository/base_reepository.dart';
import 'package:http/http.dart' as http;

class SearchRepository extends BaseRepository {
  final String labguageManga = dotenv.get("labguageManga");
  final String dataChapters = dotenv.get("dataChapters");
  final String labguageChapter = dotenv.get("labguageChapter");
  final String chapter = dotenv.get("chapter");

  Future<http.Response> getMangas(String query) async {
    final http.Response response =
        await get('manga?title=$query${labguageManga}es-la');

    return response;
  }

  Future<http.Response> getManga(String mangaId, int offset, String asc) async {
    final http.Response response = await get(
        'manga/$mangaId$dataChapters$offset&order[chapter]=$asc&${labguageChapter}es-la');

    return response;
  }

  Future<http.Response> getChapterContents(String chapterId) async {
    final http.Response response = await get('$chapter$chapterId');

    return response;
  }
}
