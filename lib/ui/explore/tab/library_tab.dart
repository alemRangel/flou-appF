import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/explore/explore_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/explore/tab/library_tab_view_model.dart';

typedef Widget BuildContent();

class LibraryTab<T extends ResourceType> extends StatelessWidget {
  final T type;

  LibraryTab({this.type});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LibraryTabViewModel<T>>(
      onInit: (store) {
        store.dispatch(FetchEnrollmentsAction(type));
      },
      distinct: true,
      converter: (store) => LibraryTabViewModel.fromStore<T>(store, type),
      builder: (_, viewModel) => ExplorePageContent(viewModel),
    );
  }
}

class ExplorePageContent extends StatelessWidget {
  final LibraryTabViewModel viewModel;

  ExplorePageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return _buildResourcesList();
  }

  Widget _buildResourcesList() {
    return LoadingView(
      status: viewModel.enrollmentsLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el recurso.',
        onRetry: () => viewModel.refreshEnrollments(viewModel.type),
      ),
      successContent: EnrollmentList(
        enrollments: viewModel.enrollments,
        onReloadCallback: () => viewModel.refreshEnrollments(viewModel.type),
        onItemSelected: (Enrollment enrollment) =>
            viewModel.enrollmentSelected(enrollment.resource.id),
        onDownload: (Enrollment enrollment) =>
            viewModel.downloadFiles(enrollment.resource.id),
      ),
    );
  }
}
