import 'package:flutter/material.dart';
import 'package:learning/data/data.dart';
import 'package:learning/ui/explore/explore_page.dart';
import 'package:learning/ui/spotlight/spotlight_page.dart';
import 'package:learning/ui/settings/settings_page.dart';
import 'package:learning/ui/achievements/achievements_page.dart';


class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    Widget child,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _child = child,
        item = BottomNavigationBarItem(
          icon: icon,
          //activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _child;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: _child,
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
      margin: EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
        margin: EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: Icon(Icons.search),
        title: 'Cursos',
        color: Colors.deepPurple,
        vsync: this,
        child: ExplorePage(type: CourseResource()),
      ),
      NavigationIconView(
        icon: Icon(Icons.accessibility),
        title: 'Meditación',
        color: Colors.deepOrange,
        vsync: this,
        child: ExplorePage(type: MeditationResource()),
      ),
      NavigationIconView(
        activeIcon: Icon(Icons.book),
        icon: Icon(Icons.book),
        title: 'Libros',
        color: Colors.teal,
        vsync: this,
        child: ExplorePage(type: BookResource()),
      ),
      NavigationIconView(
        activeIcon: Icon(Icons.favorite),
        icon: Icon(Icons.live_tv),
        title: 'Spotlight',
        color: Colors.indigo,
        vsync: this,
        child: SpotlightPage(),
      ),
      NavigationIconView(
        icon: Icon(Icons.account_circle),
        title: 'Cuenta',
        color: Colors.pink,
        vsync: this,
        child: SettingsPage(),
      ),
      NavigationIconView(
        icon: Icon(Icons.accessibility_new),
        title: 'Achievements',
        color: Colors.amber,
        vsync: this,
        child: AchievementsPage(),
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(BottomNavigationBarType.fixed, context));

    // We want to have the animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return Scaffold(
      body: Center(child: _buildTransitionsStack()),
      bottomNavigationBar: botNavBar,
    );
  }
}
