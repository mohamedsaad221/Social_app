import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/shared/components/components.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialHomeCubit.get(context).userModel;
        var profileImage = SocialHomeCubit.get(context).profileImage;
        var coverImage = SocialHomeCubit.get(context).coverImage;

        if (model!.name != null) {
          nameController.text = model.name!;
          bioController.text = model.bio!;
          phoneController.text = model.phone!;
        }

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: defaultTextButton(
                    function: () {
                      SocialHomeCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                      );
                    },
                    text: 'UPDATE'),
              )
            ],
          ),
          body: Column(
            children: [
              if (state is SocialUploadUserLoadingState)
                LinearProgressIndicator(),
              if (state is SocialUploadUserLoadingState)
                SizedBox(
                  height: 10.0,
                ),
              Container(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
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
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${model.cover}',
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider)),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        IconButton(
                          onPressed: () {
                            SocialHomeCubit.get(context).getCoverImage();
                          },
                          icon: CircleAvatar(
                            child: Icon(
                              IconBroken.Camera,
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
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 57.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 55.0,
                            backgroundImage: profileImage == null
                                ? NetworkImage('${model.image}')
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialHomeCubit.get(context).getProfileImage();
                          },
                          icon: CircleAvatar(
                            child: Icon(
                              IconBroken.Camera,
                              size: 18.0,
                              color: Colors.black,
                            ),
                            radius: 20,
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ],
                      alignment: AlignmentDirectional.bottomEnd,
                    ),
                  ],
                ),
                height: 190.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              if (SocialHomeCubit.get(context).profileImage != null ||
                  SocialHomeCubit.get(context).coverImage != null)
                Row(
                  children: [
                    if (SocialHomeCubit.get(context).profileImage != null)
                      Expanded(
                        child: defaultTextMaterialButton(
                          function: () {
                            SocialHomeCubit.get(context).uploadProfileImage(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text,
                            );
                          },
                          text: 'upload image',
                            colorText: Colors.white
                        ),
                      ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (SocialHomeCubit.get(context).coverImage != null)
                      Expanded(
                        child: defaultTextMaterialButton(
                          function: () {
                            SocialHomeCubit.get(context).uploadCoverImage(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text,
                            );
                          },
                          text: 'upload cover',
                          colorText: Colors.white
                        ),
                      ),
                  ],
                ),
              if (SocialHomeCubit.get(context).profileImage != null ||
                  SocialHomeCubit.get(context).coverImage != null)
                SizedBox(
                  height: 20.0,
                ),
              defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'name must be not empty';
                    }
                    return null;
                  },
                  labelText: 'Name',
                  prefixIcon: IconBroken.User),
              SizedBox(
                height: 10.0,
              ),
              defaultFormField(
                  controller: bioController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'bio must be not empty';
                    }
                    return null;
                  },
                  labelText: 'Bio',
                  prefixIcon: IconBroken.Info_Circle),
              SizedBox(
                height: 10.0,
              ),
              defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Phone must be not empty';
                    }
                    return null;
                  },
                  labelText: 'Phone',
                  prefixIcon: IconBroken.Info_Circle),
            ],
          ),
        );
      },
    );
  }
}
