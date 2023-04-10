import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/status.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/components/bloc _observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData( key: 'isDark');
  bool ? onBoarding = CacheHelper.getData(key: 'onBoarding');
  late Widget startWidget;
  token = CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding != null){
    if(token != null){
      startWidget = ShopLayout();
    }else{
      startWidget = ShopLoginScreen();
    }
  }else{
    startWidget = OnBoardingScreen();
  }

  print(onBoarding);
  runApp(MyApp(
    // isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {

  late Widget startWidget;
  MyApp({
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}