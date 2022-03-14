import 'package:shop_app/components/component/component.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/networt/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)) );
}

String? token;