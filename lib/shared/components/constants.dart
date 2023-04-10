import 'package:flutter/material.dart';

import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(BuildContext context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
          context: context,
          widget: ShopLoginScreen()
      );
    }
  });
}


//To print full text:

void printFullText({required String text}){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match){
    print(match.group(0));
  });
}

String ? token ;
String ? uId ;