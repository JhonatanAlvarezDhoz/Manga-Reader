part of 'search_delegate_bloc.dart';

sealed class SearchDelegateEvent extends Equatable {
  const SearchDelegateEvent();

  @override
  List<Object> get props => [];
}

class SearchManga extends SearchDelegateEvent {
  final String query;

  const SearchManga(this.query);

  @override
  List<Object> get props => [query];
}

class OnNewMangasFoundEvent extends SearchDelegateEvent {
  final List<Manga> mangas;

  const OnNewMangasFoundEvent(this.mangas);
}

class AddToHistorySearchEvent extends SearchDelegateEvent {
  final Manga manga;

  const AddToHistorySearchEvent(this.manga);
}

class SelectedMangaEvent extends SearchDelegateEvent {
  final String mangaId;

  const SelectedMangaEvent(this.mangaId);
}

class LoadMoreChaptersEvent extends SearchDelegateEvent {
  final String mangaId;

  const LoadMoreChaptersEvent({required this.mangaId});
}

class OnToggleOrderEvent extends SearchDelegateEvent {
  final String mangaId;

  const OnToggleOrderEvent({required this.mangaId});
}

class LoadChapterPagesEvent extends SearchDelegateEvent {
  final String chapterId;

  const LoadChapterPagesEvent(this.chapterId);
}

class ChangePageIndexEvent extends SearchDelegateEvent {
  final int newIndex;

  const ChangePageIndexEvent(this.newIndex);
}

class ToggleCascadeModeEvent extends SearchDelegateEvent {}

class ChangeSearchStateEvent extends SearchDelegateEvent {
  final SearchState searchState;

  const ChangeSearchStateEvent({required this.searchState});
}
