import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning/api/api.dart';
import 'package:learning/data/data.dart';
import 'package:learning/redux/app/app_middleware.dart';
import 'package:learning/redux/app/app_reducer.dart';
import 'package:learning/redux/app/app_state.dart';
import 'package:learning/redux/audio/audio_middleware.dart';
import 'package:learning/redux/auth/auth_middleware.dart';
import 'package:learning/redux/cached_files/cached_files_middleware.dart';
import 'package:learning/redux/chapter/chapter_middleware.dart';
import 'package:learning/redux/explore/explore_middleware.dart';
import 'package:learning/redux/interaction/interaction_middleware.dart';
import 'package:learning/redux/navigation/navigation_middleware.dart';
import 'package:learning/redux/notification/notification_middleware.dart';
import 'package:learning/redux/referral/referral_middleware.dart';
import 'package:learning/redux/resource/resource_middleware.dart';
import 'package:learning/redux/resource_list/resource_list_middleware.dart';
import 'package:learning/redux/search/search_middleware.dart';
import 'package:learning/redux/spotlight/spotlight_middleware.dart';
import 'package:learning/redux/subscription/subscription_middleware.dart';
import 'package:learning/search/search.dart';
import 'package:learning/utils/auth.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  var userEndpoint = UserEndpoint();
  var chapterEndpoint = ChapterEndpoint();
  var categoryEndpoint = CategoryEndpoint();
  var interactionEndpoint = InteractionEndpoint();
  var resourceEndpoint = ResourceEndpoint();
  var spotlightEndpoint = SpotlightEndpoint();
  var enrollmentEndpoint = EnrollmentEndpoint();
  var resourceIndex = ResourceIndex();
  var createEnrollment = CreateEnrollment();
  var registerSubscription = RegisterSubscription();
  var userActivationCode = UseActivationCode();
  var auth =
      Auth(firebaseAuth: FirebaseAuth.instance, userEndpoint: userEndpoint);

  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [
      AppMiddleware(),
      AudioMiddleware(),
      AuthMiddleware(auth, userEndpoint),
      CachedFilesMiddleware(resourceEndpoint, chapterEndpoint),
      SpotlightMiddleware(spotlightEndpoint),
      ResourceMiddleware(
        resourceEndpoint,
        chapterEndpoint,
        categoryEndpoint,
        enrollmentEndpoint,
        createEnrollment,
      ),
      ChapterMiddleware(chapterEndpoint),
      ExploreMiddleware<CourseResource>(
          resourceEndpoint, categoryEndpoint, enrollmentEndpoint),
      ExploreMiddleware<MeditationResource>(
          resourceEndpoint, categoryEndpoint, enrollmentEndpoint),
      ExploreMiddleware<BookResource>(
          resourceEndpoint, categoryEndpoint, enrollmentEndpoint),
      InteractionMiddleware(interactionEndpoint, enrollmentEndpoint),
      NavigationMiddleware(),
      NotificationMiddleware(),
      ReferralMiddleware(),
      ResourceListMiddleware(resourceEndpoint, categoryEndpoint),
      SearchMiddleware<LResource>(resourceIndex),
      SubscriptionMiddleware(registerSubscription, userActivationCode),
    ],
  );
}
