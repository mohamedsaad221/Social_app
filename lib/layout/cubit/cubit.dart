import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/message_model.dart';
import 'package:social_app1/models/post_model.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/chats/chats.dart';
import 'package:social_app1/modules/feeds/feeds.dart';
import 'package:social_app1/modules/posts/posts_screen.dart';
import 'package:social_app1/modules/settings/settings.dart';
import 'package:social_app1/modules/users/users.dart';
import 'package:social_app1/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialHomeCubit extends Cubit<SocialLayoutStates> {
  SocialHomeCubit() : super(SocialInitialState());

  static SocialHomeCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() async {
    emit(SocialGetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .get()
        .then((value) {
      if (value.data() != null) {
        Map<String, dynamic>? data;
        data = value.data();
        userModel = SocialUserModel.fromJson(data!);
      }

      //print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  File? profileImage;
  File? coverImage;

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected. ');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected. ');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['News Feeds', 'Chats', 'Post', 'Users', 'Settings'];

  void changeIndex(int index) {
    if (index == 1) getAllUsers();
    if (index == 2) {
      emit(SocialAddPostsSuccessState());
    } else {
      currentIndex = index;
      emit(SocialChangeNavButtonSuccessState());
    }
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    emit(SocialUploadUserLoadingState());

    SocialUserModel model = SocialUserModel(
      name: name,
      email: userModel!.email,
      uId: userModel!.uId,
      bio: bio,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      phone: phone,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUploadUserErrorState());
    });
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadImageSuccessState());
        //print(value);
        updateUser(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(SocialUploadImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverSuccessState());
        //print(value);
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialUploadPostImageSuccessState());
    } else {
      print('No image selected. ');
      emit(SocialUploadPostImageErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialUploadPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadPostErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      });

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());

    //if(users.length == 0)

    users = [];

    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        print(element.data()['uId']);
        if (element.data()['uId'] != userModel!.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      print('myId ${userModel!.uId}');
      print(users.length);
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
    required receiverId,
    required dateTime,
    required text,
  }) {
    MessageModel model = MessageModel(
        receiverId: receiverId,
        dateTime: dateTime,
        text: text,
        senderId: userModel!.uId);

    // set my chats
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSentMessageSuccessState());
    }).catchError((error) {
      emit(SocialSentMessageErrorState());
    });

    // set receiver chats
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSentMessageSuccessState());
    }).catchError((error) {
      emit(SocialSentMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessageChat({
    required receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {

      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }
}
