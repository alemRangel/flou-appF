import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:learning/ui/referral/referral_page.dart';

final referralHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ReferralPage();
});
