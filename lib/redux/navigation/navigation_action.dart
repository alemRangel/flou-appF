class NavigateAction {
  final String route;
  final bool replace;
  final bool replaceAll;

  NavigateAction(this.route, {this.replace = false, this.replaceAll = false});
}

class NavigateUrlAction {
  final String url;

  NavigateUrlAction(this.url);
}

class PopAction {}
