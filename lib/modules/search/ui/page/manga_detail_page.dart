import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_reader/base/widgets/base.dart';
import 'package:manga_reader/modules/search/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/models/manga_response.dart';
import 'package:manga_reader/modules/search/ui/page/chapter_detail_page.dart';

class MangaDexDetailView extends StatelessWidget {
  final String mangaId;
  final Manga manga;

  const MangaDexDetailView(
      {super.key, required this.mangaId, required this.manga});

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchDelegateBloc>(context);
    final String? titleEs = manga.attributes.title.es;
    final String? titleEn = manga.attributes.title.en;
    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: titleEs == null
              ? CustomText(text: "$titleEn Chapters")
              : CustomText(text: "$titleEs Capitulos"),
          actions: [
            IconButton(
              icon: Icon(state.isAscending
                  ? Icons.arrow_upward
                  : Icons.arrow_downward),
              onPressed: () => context
                  .read<SearchDelegateBloc>()
                  .add(OnToggleOrderEvent(mangaId: mangaId)),
            )
          ],
        ),
        body: BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.chapters.length,
                    itemBuilder: (context, index) {
                      final chapterA = state.chapters[index].attributes;
                      final chapter = state.chapters[index];
                      return ListTile(
                          title: Text('Capítulo ${chapterA.chapter}'),
                          subtitle: Text(chapter.attributes.title ??
                              "Title no encontrado"),
                          onTap: () async {
                            searchBloc.add(LoadChapterPagesEvent(
                                state.chapters[index].id));
                            Navigator.of(context)
                                .push(CupertinoPageRoute(builder: (context) {
                              return MangaDexChapterPage(
                                chapterId: state.chapters[index].id,
                                chapters: state.chapters,
                                currentIndex: index,
                              );
                            }));
                          });
                    },
                  ),
                ),
                if (state.hasMore)
                  SafeArea(
                    top: false,
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<SearchDelegateBloc>()
                          .add(LoadMoreChaptersEvent(mangaId: mangaId)),
                      child: const Text('Cargar más capítulos'),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    });
  }
}
