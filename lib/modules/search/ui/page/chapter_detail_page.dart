import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_reader/modules/search/bloc/search_delegate_bloc.dart';
import 'package:manga_reader/modules/search/data/models/chapters_response.dart';

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

    return BlocBuilder<SearchDelegateBloc, SearchDelegateState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Capítulo ${state.chapters[currentIndex].attributes.title}'),
            actions: [
              IconButton(
                icon: Icon(
                    state.isCascadeMode ? Icons.view_day : Icons.view_carousel),
                onPressed: () {
                  searchDelegateBloc.add(ToggleCascadeModeEvent());
                },
              ),
            ],
          ),
          body: state.chapter.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : state.isCascadeMode
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
                    child: const Icon(Icons.arrow_circle_left_sharp),
                  ),
                const Text(
                  'Powered by MangaDex',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                if (currentIndex < chapters.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      final nextIndex = currentIndex + 1;
                      searchDelegateBloc.add(
                          LoadChapterPagesEvent(state.chapters[nextIndex].id));
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
                    child: const Icon(Icons.arrow_circle_right_sharp),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
