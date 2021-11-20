
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  VoidCallback? onSubmit,
  Function? onChange,
  required FormFieldValidator validate,
  required String labelText,
  required IconData prefixIcon,
  VoidCallback? onTap,
  IconData? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (s){
          if(onSubmit != null){
            onSubmit();
          }
        },
        onChanged: (s){
          if(onChange != null){
            onChange(s);
          }
        },
        onTap: (){
          if(onTap != null){
            onTap();
          }
        },
        validator: validate,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(),
          suffixIcon: IconButton(icon: Icon(suffixIcon), onPressed: (){suffixPressed!();},),
        )
    );

Widget defaultTextButton({
  required Function function,
  required String text
}) => TextButton(
  onPressed: (){
    function();
  },
  child: Text(text),
);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTextMaterialButton({required Function function, required String text , colorText}) => Container(
  width: double.infinity,
  height: 50.0,
  color: Colors.deepOrange,
  child: MaterialButton(
    onPressed: (){function();} ,
    child: Text(text.toUpperCase(), style: TextStyle(color: colorText),),
  ),
);

void showToast({
  required String text,
  required ShowToastColor state,

}) =>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ShowToastColor {SUCCESS, ERROR, WARING}

Color chooseToastColor(ShowToastColor state) {

  Color color;

  switch(state) {
    case ShowToastColor.SUCCESS:
      color = Colors.green;
      break;
    case ShowToastColor.ERROR:
      color = Colors.red;
      break;
    case ShowToastColor.WARING:
      color = Colors.amberAccent;
      break;

  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => 
  AppBar(
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(
        IconBroken.Arrow___Left_2,
      ),
    ),
    title: Text(
      title!,
    ),
    actions: actions,
  );

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    vertical: 5.0
  ),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);

ThemeData themLight = ThemeData(
    primarySwatch: Colors.deepOrange,
    fontFamily: 'Jannah',
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
    ),
  textTheme: TextTheme(
    subtitle1: TextStyle(
      height: 1.4,
      fontSize: 14.0,
      fontWeight: FontWeight.w700
    ),
  ),
);