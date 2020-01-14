import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/api/mapper/mapper.dart';
export 'package:learning/data/author.dart';

typedef Query QueryBuilder(Query x);

abstract class Base<T> {
  final String modelName;
  final Mapper<T> mapper;

  Base(this.modelName, this.mapper);

  Future<T> getTest(String id) async {
    final response = await http.get('http://192.168.1.80:3000/$modelName/$id');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return transformTest(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> createTest(dynamic data) async{
    final response = await http.post('http://192.168.1.80:3000/',body: data);
    if (response.statusCode != 200) {
      throw Exception('Failed to create model');
    }
  }

  Future<void> updateTest(String id, dynamic data) async {
    final response = await http.put('http://192.168.1.80:3000/', body: data);
    if (response.statusCode != 200) {
      throw Exception('Failed to update model');
    }
  }

  Future<void> deleteTest(String id) async {
    final response = await http.delete('http://192.168.1.80:3000/$modelName/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete model');
    }
  }

  Future<List<T>> listTest() async {
    final response = await http.get('http://192.168.1.80:3000/$modelName');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var objectsJson = jsonDecode(response.body)[modelName] as List;
      List<T> objectsT = objectsJson.map((jsonT) => transformTest(jsonT)).toList();
      return objectsT;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  T transformTest(Map<String, dynamic> json) {
    return mapper.transformT(json);
  }


  /*DONE*/
  Future<T> get(String id) async {
    DocumentSnapshot snapshot = await Firestore.instance.document('$modelName/$id').get();
    return transform(snapshot);
  }
  /*DONE*/
  Future<List<T>> list() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection(modelName).getDocuments();
    return querySnapshot.documents.map(transform).toList();
  }

  /*NOT AVAILABLE IN SERVER*/
  Future<void> create(dynamic data) {
    return Firestore.instance.collection(modelName).add(data);
  }

  /*NOT AVAILABLE IN SERVER*/
  Future<void> update(String id, dynamic data) {
    return Firestore.instance.document('$modelName/$id').updateData(data);
  }

  /*...*/
  Future<T> getWithQuery(QueryBuilder queryBuilder) async {
    try {
      List<T> docs = await listWithQuery(queryBuilder);
      return docs.first;
    } catch (e) {
      print(e);
    }
    return null;
  }
  Future<List<T>> listWithQuery(QueryBuilder queryBuilder) async {
    Query base = Firestore.instance.collection(modelName);
    Query query = queryBuilder(base);

    QuerySnapshot querySnapshot = await query.getDocuments();
    return querySnapshot.documents.map(transform).toList();
  }
  /*...*/

  /*NOT SURE!*/
  Stream<T> subscribe(String id) {
    return Firestore.instance.document('$modelName/$id').snapshots().transform(
      StreamTransformer.fromHandlers(
        handleData: (DocumentSnapshot snapshot, EventSink<T> sink) {
          sink.add(transform(snapshot));
        },
      ),
    );
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
