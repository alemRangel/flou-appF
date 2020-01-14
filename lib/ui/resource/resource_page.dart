import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/resource/resource_actions.dart';
import 'package:learning/ui/common/common.dart';
import 'package:learning/ui/resource/resource_view_model.dart';
import 'package:learning/ui/resource/widget/enrollment_dialog.dart';
import 'package:learning/ui/resource/widget/resource_chapter_list.dart';
import 'package:learning/ui/resource/widget/resource_content.dart';
import 'package:learning/ui/resource/widget/resource_cover.dart';

class ResourcePage extends StatelessWidget {
  final String id;

  ResourcePage({this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ResourcePageViewModel>(
      onInit: (store) {
        store.dispatch(FetchResourceAction(id));
        store.dispatch(FetchChaptersAction(id));
        store.dispatch(FetchEnrollmentAction(id));
      },
      distinct: true,
      converter: (store) => ResourcePageViewModel.fromStore(store),
      builder: (_, viewModel) => ResourcePageContent(viewModel),
    );
  }
}

class ResourcePageContent extends StatelessWidget {
  final ResourcePageViewModel viewModel;

  ResourcePageContent(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          ResourceCover(viewModel.resource?.landscapeImageUrl),
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                _buildResource(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResource(BuildContext context) {
    return LoadingView(
      status: viewModel.resourceLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'Hubo un problema cargando el recurso.',
        onRetry: () => viewModel.refreshResource(viewModel.resource.id),
      ),
      successContent: ResourceContent(
        resource: viewModel.resource,
        category: viewModel.category,
        enrollment: viewModel.enrollment,
        enrollmentLoadingStatus: viewModel.enrollmentLoadingStatus,
        onActionTap: () => _resourceAction(context),
      ),
    );
  }

  Widget _buildChapterList() {
    return LoadingView(
      status: viewModel.chaptersLoadingStatus,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: 'No pudimos cargar los capítulos.',
        onRetry: () => viewModel.refreshChapters(viewModel.resource.id),
      ),
      successContent: ResourceChapterList(
        chapters: viewModel.chapters,
        enrollment: viewModel.enrollment,
      ),
    );
  }

  void _resourceAction(BuildContext context) {
    if (!viewModel.hasSubscription) {
      viewModel.subscribe();
    } else if (viewModel.enrollment == null) {
      _showDialog(context);
    } else {
      _openChapters(context);
    }
  }

  void _showDialog(BuildContext context) {
    showDialog<EnrollmentDialogAction>(
      context: context,
      builder: (BuildContext context) {
        return EnrollmentDialog(
          title:
              '¿Quieres agregar ${viewModel.resource.title} a tu biblioteca?',
          content: '',
          onAgree: () => viewModel.enroll(viewModel.resource.id),
        );
      },
    );
  }

  void _openChapters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          child: SingleChildScrollView(
            child: _buildChapterList(),
          ),
        );
      },
    );
  }
}
