import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/base/ui/widgets/base.dart';
import 'package:manga_reader/localization/languageManager.dart';
import 'package:manga_reader/modules/home/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/models/manga_response.dart';
import 'package:manga_reader/modules/search/ui/page/chapter_detail_page.dart';
import 'package:manga_reader/themes/theme_colors.dart';

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
            GestureDetector(
              onTap: () => searchBloc.add(OnToggleOrderEvent(mangaId: mangaId)),
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                height: 25,
                width: 20,
                child: state.isAscending
                    ? SvgPicture.asset(
                        "assets/icons/ascending.svg",
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      )
                    : SvgPicture.asset(
                        "assets/icons/descending.svg",
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
              ),
            ),
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
                          title: Text(
                              '${LanguageManager().translate().chapter} ${chapterA.chapter}'),
                          subtitle: Text(chapter.attributes.title ??
                              LanguageManager().translate().titleNotFound),
                          trailing: SvgPicture.asset(
                            "assets/icons/play.svg",
                            width: 30,
                            color: ThemeColors.hintColor,
                          ),
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
                      child: CustomText(
                        text: LanguageManager().translate().uploadMoreChapters,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ThemeColors.hintColor,
                      ),
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
