import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/endpoint/base.dart';
import 'package:learning/api/mapper/spotlight.dart';
import 'package:learning/data/data.dart';

class SpotlightEndpoint extends Base<Spotlight> {
  SpotlightEndpoint() : super('spotlights', SpotlightMapper());

  @override
  Future<List<Spotlight>> list() {
    return listWithQuery((Query query) =>
        query.where('published', isEqualTo: true).orderBy('createdAt'));
  }
}
