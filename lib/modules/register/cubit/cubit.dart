import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitial());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {

     createUser(
       name: name,
       email: email,
       uId: value.user!.uid,
       phone: phone,
     );

    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }


  void createUser({
  required String name,
  required String email,
  required String uId,
   String? bio,
   String? image,
   String? cover,
  required String phone,
}){

    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      uId: uId,
      bio:bio,
      image:'https://i.imgur.com/8UJtgPX.jpg',
      cover:'https://i.imgur.com/8qA4rd2.jpg',
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(SocialCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.remove_red_eye_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_rounded;

    emit(SocialRegisterPasswordVisibility());
  }
}
