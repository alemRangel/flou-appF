import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/mapper/mapper.dart';

typedef Query QueryBuilder(Query x);

abstract class Base<T> {
  final String modelName;
  final Mapper<T> mapper;

  Base(this.modelName, this.mapper);

  Future<T> get(String id) async {
    DocumentSnapshot snapshot =
        await Firestore.instance.document('$modelName/$id').get();
    return transform(snapshot);
  }

  Future<T> getWithQuery(QueryBuilder queryBuilder) async {
    try {
      List<T> docs = await listWithQuery(queryBuilder);
      return docs.first;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<T>> list() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection(modelName).getDocuments();
    return querySnapshot.documents.map(transform).toList();
  }

  Future<List<T>> listWithQuery(QueryBuilder queryBuilder) async {
    Query base = Firestore.instance.collection(modelName);
    Query query = queryBuilder(base);

    QuerySnapshot querySnapshot = await query.getDocuments();
    return querySnapshot.documents.map(transform).toList();
  }

  Future<void> create(dynamic data) {
    return Firestore.instance.collection(modelName).add(data);
  }

  T transform(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data;
      data.putIfAbsent('id', () => snapshot.documentID);
      return mapper.transform(data);
    }
    return null;
  }
}
