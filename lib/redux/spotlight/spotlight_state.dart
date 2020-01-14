import 'package:learning/data/data.dart';
import 'package:meta/meta.dart';

@immutable
class SpotlightState {
  final List<Spotlight> spotlights;
  final LoadingStatus loadingStatus;

  SpotlightState({
    @required this.loadingStatus,
    @required this.spotlights,
  });

  factory SpotlightState.initial() {
    return SpotlightState(
      loadingStatus: LoadingStatus.loading,
      spotlights: <Spotlight>[],
    );
  }

  SpotlightState copyWith({
    LoadingStatus loadingStatus,
    List<Spotlight> spotlights,
  }) {
    return SpotlightState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      spotlights: spotlights ?? this.spotlights,
    );
  }

  @override
  int get hashCode => loadingStatus.hashCode ^ spotlights.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpotlightState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          spotlights == other.spotlights;

  @override
  String toString() {
    return 'SpotlightState{loadingStatus: $loadingStatus, spotlights: $spotlights}';
  }
}
