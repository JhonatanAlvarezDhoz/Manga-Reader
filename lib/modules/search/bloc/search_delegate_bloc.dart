import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_reader/base/use_case/base_use_case.dart';
import 'package:manga_reader/modules/search/data/models/chapter_data_response.dart';
import 'package:manga_reader/modules/search/data/models/chapters_response.dart';

import 'package:manga_reader/modules/search/data/models/manga_response.dart';
import 'package:manga_reader/modules/search/data/use_case/use_case.dart';

part 'search_delegate_event.dart';
part 'search_delegate_state.dart';

class SearchDelegateBloc
    extends Bloc<SearchDelegateEvent, SearchDelegateState> {
  SearchDelegateBloc({
    required this.getMangasUseCase,
    required this.getMangaUseCase,
    required this.getChapterUseCase,
  }) : super(const SearchDelegateState()) {
    on<SearchManga>(_searchMangas);
    on<AddToHistorySearchEvent>(_addToHistory);
    on<SelectedMangaEvent>(_selectedManga);
    on<LoadMoreChaptersEvent>(_onLoadMoreChapters);
    on<OnToggleOrderEvent>(_onToggleOrder);
    on<LoadChapterPagesEvent>(_loadChapterPages);
    on<ChangePageIndexEvent>(_changePageIndex);
    on<ChangeSearchStateEvent>(_changeSearchState);
  }

  final GetMangasUseCase getMangasUseCase;
  final GetMangaUseCase getMangaUseCase;
  final GetChapterUseCase getChapterUseCase;

  Future<void> _searchMangas(
    SearchManga event,
    Emitter<SearchDelegateState> emit,
  ) async {
    try {
      MangaResponse response = await getMangasUseCase.call(
          params: GetMangasUseCaseParams(event.query));

      if (response.runtimeType == MangaResponse) {
        emit(state.copyWith(mangas: response.data));
      }
    } on UseCaseException catch (e) {
      emit(state.copyWith(
        errorText: e.message,
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addToHistory(
    AddToHistorySearchEvent event,
    Emitter<SearchDelegateState> emit,
  ) async {
    emit(state.copyWith(historySearch: [event.manga, ...state.historySearch]));
  }

  Future<void> _selectedManga(
    SelectedMangaEvent event,
    Emitter<SearchDelegateState> emit,
  ) async {
    try {
      ChaptersResponse response = await getMangaUseCase.call(
          params: GetMangaUseCaseParams(
              mangaId: event.mangaId,
              offset: state.offset.toInt(),
              order: state.isAscending ? 'asc' : 'desc'));

      if (response.runtimeType == ChaptersResponse) {
        final List<Chapters> chapters = response.data;
        emit(state.copyWith(
          chapters: chapters,
          offset: state.offset + chapters.length,
          isLoading: false,
          hasMore: chapters.length == 15,
        ));
      }
    } on UseCaseException catch (e) {
      emit(state.copyWith(
        errorText: e.message,
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onLoadMoreChapters(
    LoadMoreChaptersEvent event,
    Emitter<SearchDelegateState> emit,
  ) async {
    try {
      final ChaptersResponse manga = await getMangaUseCase.call(
        params: GetMangaUseCaseParams(
          mangaId: event.mangaId,
          offset: state.offset.toInt(),
          order: state.isAscending ? 'asc' : 'desc',
        ),
      );
      if (manga.runtimeType == ChaptersResponse) {
        final List<Chapters> chapters = manga.data;
        emit(state.copyWith(
          chapters: chapters,
          offset: state.offset + chapters.length,
          isLoading: false,
          hasMore: chapters.length == 15,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, hasMore: false));
      throw Exception('Error al cargar los capítulos del manga');
    }
  }

  void _onToggleOrder(
      OnToggleOrderEvent event, Emitter<SearchDelegateState> emit) {
    emit(state.copyWith(
      isAscending: !state.isAscending,
      chapters: [],
      offset: 0,
      hasMore: true,
    ));
    add(LoadMoreChaptersEvent(mangaId: event.mangaId));
  }

  Future<void> _loadChapterPages(
    LoadChapterPagesEvent event,
    Emitter<SearchDelegateState> emit,
  ) async {
    try {
      ChapterDataResponse response = await getChapterUseCase.call(
          params: GetChapterUseCaseParams(event.chapterId));

      if (response.runtimeType == ChapterDataResponse) {
        final baseUrl = response.baseUrl;
        final hash = response.chapter.hash;
        final pageData = response.chapter.data;
        final pages = pageData
            .map<String>((page) => '$baseUrl/data/$hash/$page')
            .toList();
        emit(state.copyWith(chapter: pages, currentIndex: 0));
      } else {
        throw Exception('Error al cargar las páginas del capítulo');
      }
    } catch (e) {
      emit(state.copyWith(
        errorText: e.toString(),
      ));
    }
  }

  void _changePageIndex(
    ChangePageIndexEvent event,
    Emitter<SearchDelegateState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.newIndex));
  }

  void _changeSearchState(
    ChangeSearchStateEvent event,
    Emitter<SearchDelegateState> emit,
  ) {
    emit(state.copyWith(searchState: event.searchState));
  }
}
