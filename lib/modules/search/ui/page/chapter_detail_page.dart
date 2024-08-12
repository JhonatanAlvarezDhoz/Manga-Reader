import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/localization/languageManager.dart';
import 'package:manga_reader/modules/home/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/models/chapters_response.dart';
import 'package:manga_reader/modules/settings/bloc/settings_bloc.dart';
import 'package:manga_reader/themes/theme_colors.dart';

class MangaDexChapterPage extends StatelessWidget {
  final String chapterId;
  final List<Chapters> chapters;
  final int currentIndex;

  const MangaDexChapterPage({
    super.key,
    required this.chapterId,
    required this.chapters,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final searchDelegateBloc = BlocProvider.of<SearchDelegateBloc>(context);
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
      builder: (context, state) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    '${LanguageManager().translate().chapter} ${state.chapters[currentIndex].attributes.title}'),
                actions: [
                  GestureDetector(
                    onTap: () => settingsBloc.add(ToggleViewModeEvent()),
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      height: 25,
                      width: 30,
                      child: settingState.isCascadeView
                          ? SvgPicture.asset(
                              "assets/icons/view.svg",
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            )
                          : SvgPicture.asset(
                              "assets/icons/offView.svg",
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                    ),
                  ),
                ],
              ),
              body: state.chapter.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : settingState.isCascadeView
                      ? ListView.builder(
                          itemCount: state.chapter.length,
                          itemBuilder: (context, index) {
                            return Image.network(state.chapter[index]);
                          },
                        )
                      : PageView.builder(
                          itemCount: state.chapter.length,
                          onPageChanged: (index) {
                            searchDelegateBloc.add(ChangePageIndexEvent(index));
                          },
                          itemBuilder: (context, index) {
                            return Image.network(state.chapter[index]);
                          },
                        ),
              bottomNavigationBar: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                          final previousIndex = currentIndex - 1;
                          searchDelegateBloc.add(LoadChapterPagesEvent(
                              state.chapters[previousIndex].id));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MangaDexChapterPage(
                                chapterId: chapters[previousIndex].id,
                                chapters: chapters,
                                currentIndex: previousIndex,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_circle_left_sharp,
                          color: ThemeColors.hintColor,
                        ),
                      ),
                    const Text(
                      "Data from the MangaDex API.",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    if (currentIndex < chapters.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          final nextIndex = currentIndex + 1;
                          searchDelegateBloc.add(LoadChapterPagesEvent(
                              state.chapters[nextIndex].id));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MangaDexChapterPage(
                                chapterId: chapters[nextIndex].id,
                                chapters: chapters,
                                currentIndex: nextIndex,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_sharp,
                          color: ThemeColors.hintColor,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
