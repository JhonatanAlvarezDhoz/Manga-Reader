import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/base/ui/widgets/base.dart';
import 'package:manga_reader/modules/home/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/models/searchh_result.dart';
import 'package:manga_reader/modules/search/ui/page/manga_detail_page.dart';
import 'package:manga_reader/themes/theme_colors.dart';
import 'package:manga_reader/utils/responsive.dart';

class SearchMangaDelegate extends SearchDelegate<SearchResult> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    const String assetName = 'assets/images/folder.svg';
    final ThemeData theme = Theme.of(context);
    final searchBloc = BlocProvider.of<SearchDelegateBloc>(context);
    final size = Responsive.of(context);
    searchBloc.add(SearchManga(query));

    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
        builder: ((context, state) {
      final mangas = state.mangas;
      return mangas.isEmpty
          ? Container(
              width: size.widthResponsive(100),
              height: size.widthResponsive(100),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    assetName,
                    semanticsLabel: 'Empty icon',
                    width: size.diagonalResponsive(31),
                    color: theme.hintColor,
                  ),
                  CustomText(
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      text:
                          'Lo sentimos en el momento no contamos con el titulo "$query"')
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (context, i) {
                final manga = mangas[i].attributes;
                return ListTile(
                  title: CustomText(
                      text: manga.title.es ??
                          manga.title.en ??
                          "Sin título disponible"),
                  subtitle: CustomText(
                    text: manga.description.es ??
                        manga.description.en ??
                        "Sin descripción disponible",
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    fontSize: 15,
                  ),
                  trailing: SvgPicture.asset(
                    "assets/icons/book.svg",
                    color: ThemeColors.hintColor,
                  ),
                  onTap: () {
                    searchBloc.add(AddToHistorySearchEvent(state.mangas[i]));
                    searchBloc.add(SelectedMangaEvent(state.mangas[i].id));
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return MangaDexDetailView(
                        mangaId: state.mangas[i].id,
                        manga: state.mangas[i],
                      );
                    }));
                  },
                );
              },
              separatorBuilder: (context, i) => const Divider(),
              itemCount: mangas.length,
            );
    }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchDelegateBloc>(context);

    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
        builder: ((context, state) {
      final mangas = state.historySearch;
      return ListView.separated(
        itemBuilder: (context, i) {
          final manga = mangas[i].attributes;
          return ListTile(
            title: CustomText(
                text: manga.title.es ??
                    manga.title.en ??
                    "Sin título disponible"),
            subtitle: CustomText(
              text: manga.description.es ??
                  manga.description.en ??
                  "Sin descripción disponible",
              textOverflow: TextOverflow.ellipsis,
              maxLines: 2,
              fontSize: 15,
            ),
            trailing: const Icon(
              Icons.movie_filter_outlined,
              color: Colors.black,
            ),
            onTap: () {
              searchBloc.add(AddToHistorySearchEvent(state.mangas[i]));
              searchBloc.add(SelectedMangaEvent(state.mangas[i].id));
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return MangaDexDetailView(
                  mangaId: state.mangas[i].id,
                  manga: state.mangas[i],
                );
              }));
            },
          );
        },
        separatorBuilder: (context, i) => const Divider(),
        itemCount: mangas.length,
      );
    }));
  }
}
