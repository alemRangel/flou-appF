import 'dart:async';

import 'rpc.dart';

class UseActivationCode extends Rpc {
  Future<bool> call(String code) async {
    try {
      dynamic data = await callFunction('useActivationCode', {
        'code': code,
      });
      return data['successful'];
    } catch (e) {
      print(e);
      return null;
    }
  }
}
