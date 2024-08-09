import 'package:manga_reader/utils/preferences/reading_progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveManager {
  //Reading Progress
  static Future<void> saveProgress(ReadingProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('mangaId', progress.mangaId);
    prefs.setString('chapterId', progress.chapterId);
  }

  static Future<ReadingProgress?> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final mangaTitle = prefs.getString('mangaId');
    final chapterId = prefs.getString('chapterId');

    if (mangaTitle != null && chapterId != null) {
      return ReadingProgress(mangaId: mangaTitle, chapterId: chapterId);
    } else {
      return null;
    }
  }

  //Darck Mode
  static Future<void> saveDarckMode(bool isDarcMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarcMode', isDarcMode);
  }

  static Future<bool?> loadDarckMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarcMode = prefs.getBool('isDarcMode');

    if (isDarcMode != null) {
      return isDarcMode;
    } else {
      return null;
    }
  }

  //View Chapter Mode
  static Future<void> saveViewChapterMode(bool isCascadeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCascadeMode', isCascadeMode);
  }

  static Future<bool?> loadViewChapterMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isCascadeMode = prefs.getBool('isCascadeMode');

    if (isCascadeMode != null) {
      return isCascadeMode;
    } else {
      return null;
    }
  }

  //Change Labguage
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', languageCode);
  }

  static Future<String?> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageCode');
  }
}
