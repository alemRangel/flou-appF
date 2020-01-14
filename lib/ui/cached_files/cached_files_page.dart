import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/cached_files/cached_files_actions.dart';
import 'package:learning/ui/cached_files/cached_files_view_model.dart';
import 'package:learning/ui/common/common.dart';

import 'widget/cached_file_list.dart';

class CachedFilesPage extends StatelessWidget {
  final TargetPlatform platform;

  CachedFilesPage({Key key, this.platform}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CachedFilesPageViewModel>(
      onInit: (store) => store.dispatch(FetchFilesAction()),
      distinct: true,
      converter: (store) => CachedFilesPageViewModel.fromStore(store),
      builder: (_, viewModel) => CachedFilesPageContent(viewModel, platform),
    );
  }
}

class CachedFilesPageContent extends StatelessWidget {
  final CachedFilesPageViewModel viewModel;
  final TargetPlatform platform;

  CachedFilesPageContent(this.viewModel, this.platform);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descargas'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _buildCachedFiles();
  }

  Widget _buildCachedFiles() {
    return LoadingView(
      status: viewModel.loadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando los archivos descargados.',
        onRetry: null,
      ),
      successContent: CachedFileList(
        cachedFiles: viewModel.cachedFiles,
        onReloadCallback: null,
        onItemSelected: viewModel.downloadAction,
        onItemDeleted: viewModel.deleteFile,
      ),
    );
  }
}
