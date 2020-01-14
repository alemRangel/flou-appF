import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/ui/explore/explore_view_model.dart';
import 'package:learning/ui/explore/tab/explore_tab.dart';
import 'package:learning/ui/explore/tab/library_tab.dart';
import 'package:learning/ui/search/search_page.dart';
import 'package:meta/meta.dart';

class ExplorePage<T extends ResourceType> extends StatefulWidget {
  final T type;

  ExplorePage({this.type});

  @override
  State createState() => _ExplorePageState<T>();
}

class _ExplorePageState<T extends ResourceType> extends State<ExplorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = new ScrollController();
  final SearchDelegate<LResource> _delegate = SearchPage();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExplorePageViewModel<T>>(
      distinct: true,
      converter: (store) =>
          ExplorePageViewModel.fromStore<T>(store, widget.type),
      builder: (_, viewModel) => ExplorePageContent<T>(
            type: widget.type,
            viewModel: viewModel,
            delegate: _delegate,
            scaffoldKey: _scaffoldKey,
            scrollController: _scrollController,
          ),
    );
  }
}

class ExplorePageContent<T extends ResourceType> extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScrollController scrollController;
  final SearchDelegate<LResource> delegate;
  final ExplorePageViewModel viewModel;
  final T type;

  ExplorePageContent({
    @required this.viewModel,
    @required this.scaffoldKey,
    @required this.delegate,
    @required this.scrollController,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildHeader(context),
            ];
          },
          body: _tabsViews(),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverAppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0),
        child: Image.asset(
          'assets/images/logo_white.png',
          fit: BoxFit.fitHeight,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          tooltip: 'Buscar',
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch<LResource>(
              context: context,
              delegate: delegate,
            );
          },
        ),
        IconButton(
          tooltip: 'Descargas',
          icon: const Icon(Icons.file_download),
          onPressed: () => viewModel.navigateTo('/cached-files'),
        ),
      ],
      elevation: 0.0,
      automaticallyImplyLeading: false,
      bottom: TabBar(
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10.0),
        labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        indicatorColor: Colors.white,
        tabs: [
          Tab(text: 'Explorar'),
          Tab(text: 'Biblioteca'),
        ],
      ),
    );
  }

  Widget _tabsViews() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        ExploreTab<T>(type: type),
        LibraryTab<T>(type: type),
      ],
    );
  }
}
