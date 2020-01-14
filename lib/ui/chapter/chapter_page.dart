import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/audio_player/audio_player_page.dart';
import 'package:learning/ui/chapter/chapter_view_model.dart';
import 'package:learning/ui/chapter/widget/chapter_content.dart';
import 'package:learning/ui/chapter_list/chapter_list.dart';
import 'package:learning/ui/common/common.dart';

class ChapterPage extends StatelessWidget {
  final String id;

  ChapterPage({this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ChapterPageViewModel>(
      onInit: (store) => ChapterPageViewModel.onInit(store, id),
      distinct: true,
      converter: (store) => ChapterPageViewModel.fromStore(store),
      builder: (_, viewModel) => ChapterPageContent(viewModel, id),
    );
  }
}

class ChapterPageContent extends StatelessWidget {
  final ChapterPageViewModel viewModel;
  final String chapterKey;

  ChapterPageContent(this.viewModel, this.chapterKey);

  @override
  Widget build(BuildContext context) {
    String title = viewModel.chapter?.title ?? 'Cargando...';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      endDrawer: Drawer(
        child: ChapterList(
          header: ProgressDrawerHeader(
            headerTitle: viewModel.resource.title,
            headerImageUrl: viewModel.resource.landscapeImageUrl,
          ),
          onChapterTapped: () => Navigator.pop(context),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildBody() {
    return LoadingView(
      status: viewModel.chapterLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'No pudimos cargar los capítulos.',
        onRetry: () => viewModel.refreshChapter(chapterKey),
      ),
      successContent: ChapterContent(
        currentChapter: viewModel.chapter,
        resource: viewModel.resource,
      ),
    );
  }

  Widget _buildNavigationBar() {
    final String previousId = _getPreviousChapterKey();
    final String nextId = _getNextChapterKey();

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton.icon(
            icon: const Icon(Icons.skip_previous),
            label: const Text('Anterior'),
            onPressed:
                previousId == null ? null : () => _openChapter(previousId),
          ),
          FlatButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Siguiente'),
                const SizedBox(width: 8.0),
                Icon(Icons.skip_next),
              ],
            ),
            onPressed: nextId == null ? null : () => _openChapter(nextId),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    if (viewModel.chapter?.audioUrl == null) return null;
    return FloatingActionButton(
      onPressed: () => _openAudioPlayer(context),
      child: Icon(Icons.headset, color: Colors.black87),
    );
  }

  void _openAudioPlayer(BuildContext context) {
    Navigator.push<Null>(
      context,
      MaterialPageRoute(
        builder: (_) => AudioPlayerPage(
              audioUrl: viewModel.chapter.audioUrl,
              imageUrl: viewModel.resource.imageUrl,
              label: viewModel.chapter.title,
            ),
      ),
    );
  }

  void _openChapter(String chapterId) {
    viewModel.refreshChapter(chapterId);
  }

  String _getNextChapterKey() {
    return _getChapterAtOffset(viewModel.chapters, viewModel.chapter, 1);
  }

  String _getPreviousChapterKey() {
    return _getChapterAtOffset(viewModel.chapters, viewModel.chapter, -1);
  }

  String _getChapterAtOffset(List<Chapter> chapters, chapter, int offset) {
    if (viewModel.chapter == null) return null;
    int currentChapterIndex = viewModel.chapters
        .indexWhere((Chapter chapter) => chapter.id == viewModel.chapter.id);
    int targetIndex = currentChapterIndex + offset;
    if (targetIndex >= viewModel.chapters.length || targetIndex < 0) {
      return null;
    }
    return viewModel.chapters.elementAt(targetIndex).id;
  }
}
