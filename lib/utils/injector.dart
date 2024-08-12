// ignore_for_file: depend_on_referenced_packages

import 'package:manga_reader/modules/home/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/repository/r_search.dart';
import 'package:manga_reader/modules/search/data/use_case/use_case.dart';
import 'package:manga_reader/modules/settings/bloc/settings_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    BlocProvider(create: (_) => SettingsBloc()),
    BlocProvider(
      create: (_) => SearchDelegateBloc(
        getMangasUseCase: GetMangasUseCase(repository: SearchRepository()),
        getMangaUseCase: GetMangaUseCase(repository: SearchRepository()),
        getChapterUseCase: GetChapterUseCase(repository: SearchRepository()),
      ),
    ),
  ];
}
