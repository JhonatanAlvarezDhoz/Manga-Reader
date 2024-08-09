part of 'search_delegate_bloc.dart';

enum SearchState {
  initial,
  loading,
  loaded,
  error,
}

class SearchDelegateState extends Equatable {
  final SearchState searchState;
  final List<Manga> mangas;
  final List<Chapters> chapters;
  final List<String> chapter;
  final List<Manga> historySearch;
  final String errorText;
  final int currentIndex;

  //consult manage
  final num offset;
  final bool isLoading;
  final bool hasMore;
  final bool isAscending;

  const SearchDelegateState({
    this.searchState = SearchState.initial,
    this.mangas = const [],
    this.chapters = const [],
    this.chapter = const [],
    this.historySearch = const [],
    this.errorText = "",
    this.currentIndex = 0,
    //consult manage
    this.offset = 0,
    this.isLoading = false,
    this.hasMore = true,
    this.isAscending = true,
  });

  SearchDelegateState copyWith({
    SearchState? searchState,
    List<Manga>? mangas,
    List<Chapters>? chapters,
    List<String>? chapter,
    List<Manga>? historySearch,
    Manga? manga,
    String? errorText,
    int? currentIndex,

    //consult manage
    num? offset,
    bool? isLoading,
    bool? hasMore,
    bool? isAscending,
  }) =>
      SearchDelegateState(
        searchState: searchState ?? this.searchState,
        mangas: mangas ?? this.mangas,
        chapters: chapters ?? this.chapters,
        chapter: chapter ?? this.chapter,
        historySearch: historySearch ?? this.historySearch,
        errorText: errorText ?? this.errorText,
        currentIndex: currentIndex ?? this.currentIndex,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isAscending,
        isAscending: isAscending ?? this.isAscending,
      );

  @override
  List<Object> get props => [
        searchState,
        mangas,
        historySearch,
        errorText,
        chapters,
        offset,
        isLoading,
        hasMore,
        isLoading,
        currentIndex,
      ];
}
