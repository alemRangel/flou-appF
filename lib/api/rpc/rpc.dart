import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';

class Rpc {
  Future<dynamic> callFunction(
      String functionName, Map<String, String> parameters) async {
    try {
      return await CloudFunctions.instance.call(
        functionName: functionName,
        parameters: parameters,
      );
    } on CloudFunctionsException catch (e) {
      print('Caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
      throw e;
    } catch (e) {
      print('Caught generic exception');
      print(e);
      throw e;
    }
  }
}
