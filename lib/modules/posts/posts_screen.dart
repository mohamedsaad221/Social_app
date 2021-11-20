import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/shared/components/components.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

class PostsScreen extends StatelessWidget {
  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
              function: () {
                var now = DateTime.now();
                if (SocialHomeCubit.get(context).postImage == null) {
                  SocialHomeCubit.get(context).createPost(
                    dateTime: now.toString(),
                    text: postController.text,
                  );
                } else {
                  SocialHomeCubit.get(context).uploadPostImage(
                    dateTime: now.toString(),
                    text: postController.text,
                  );
                }
              },
              text: 'Post',
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://i.imgur.com/8UJtgPX.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Mohamed Saad',
                                style: TextStyle(height: 1.3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      hintText: 'what is your mind, Mohamed',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialHomeCubit.get(context).postImage != null)
                  Stack(
                  children: [
                    Align(
                      child: Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(SocialHomeCubit.get(context).postImage!)
                            )
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    IconButton(
                      onPressed: () {
                        SocialHomeCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        child: Icon(
                          Icons.close,
                          size: 18.0,
                          color: Colors.black,
                        ),
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                      ),
                    )
                  ],
                  alignment: AlignmentDirectional.topEnd,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialHomeCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add photo'
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                              '# Tags'
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
