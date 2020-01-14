import 'package:fluro/fluro.dart';
import 'package:learning/navigation/audio_player.dart';
import 'package:learning/navigation/auth.dart';
import 'package:learning/navigation/cached_files.dart';
import 'package:learning/navigation/chapter.dart';
import 'package:learning/navigation/dashboard.dart';
import 'package:learning/navigation/referral.dart';
import 'package:learning/navigation/resource.dart';
import 'package:learning/navigation/resource_list.dart';
import 'package:learning/navigation/subscription.dart';

final router = Router();

void defineRoutes(Router router) {
  router.define('/auth', handler: authHandler);
  router.define('/cached-files', handler: cachedFilesHandler);
  router.define('/dashboard', handler: dashboardHandler);
  router.define('/audio-player', handler: audioPlayerHandler);
  router.define('/chapters/:id', handler: chapterHandler);
  router.define('/referral', handler: referralHandler);
  router.define('/resources', handler: resourceListHandler);
  router.define('/resources/:id', handler: resourceHandler);
  router.define('/subscription', handler: subscriptionHandler);
}
