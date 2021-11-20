import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/layout/social_layout.dart';
import 'package:social_app1/modules/login/login_screen.dart';
import 'package:social_app1/shared/components/components.dart';
import 'package:social_app1/shared/components/constants.dart';
import 'package:bloc/bloc.dart';


import 'shared/network/local/shared_pref.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  late Widget widget;

  uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialHomeCubit()..getUserData()..getPosts()..getAllUsers(),
      child: BlocConsumer<SocialHomeCubit , SocialLayoutStates>(
        listener: (context, state) {},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themLight,
            home: startWidget,
          );
        },
      ),
    );
  }
}
