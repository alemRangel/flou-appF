import 'package:learning/data/data.dart';

class FetchSpotlightsAction {}

class FetchSpotlightsSucceededAction {
  final List<Spotlight> spotlights;

  FetchSpotlightsSucceededAction(this.spotlights);
}

class FetchSpotlightsFailedAction {
  final Exception error;

  FetchSpotlightsFailedAction(this.error);
}

