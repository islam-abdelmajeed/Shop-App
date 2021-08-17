import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/networt/local/cache_helper.dart';
import 'package:shop_app/networt/remote/dio_helper.dart';
import 'package:shop_app/style/theme.dart';
import 'components/constant/constant.dart';
import 'modules/onboarding/onboard_screen.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  Widget widget;
  bool onboarding = CacheHelper.getData(key: 'onboarding');
  token=  CacheHelper.getData(key: 'token');

  if(onboarding != null && onboarding != false){
    if(token !=null) widget = ShopLayout();
    else widget = LoginScreen();
  }else{
    widget = OnBoardScreen();
  }
  runApp(MyApp(startWidget : widget));
}


class MyApp extends StatelessWidget {
  final Widget startWidget;

   MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget ,
    );
  }
}
