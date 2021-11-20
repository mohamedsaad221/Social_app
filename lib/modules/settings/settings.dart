import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app1/shared/components/components.dart';
import 'package:social_app1/shared/components/constants.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit , SocialLayoutStates>(
      listener: (context , state){},
      builder: (context, state){
        var model = SocialHomeCubit.get(context).userModel;
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
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
                                    image: NetworkImage(
                                      '${model!.cover}',
                                    ),
                                  )),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          CircleAvatar(
                            radius: 57.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 55.0,
                              backgroundImage:
                              NetworkImage('${model.image}'),
                            ),
                          ),
                        ],
                      ),
                      height: 190.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${model.name}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '${model.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '100',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'posts',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '254',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Photos',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '10K',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Followers',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    '53',
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    'Followings',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(onPressed: (){
                      signOut(context);
                      SocialHomeCubit.get(context).currentIndex = 0;
                    },
                    child: Text(
                      'Sign Out'
                    ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                                'Edit Profile'
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(context, EditProfileScreen());
                          },
                          child: Icon(
                              IconBroken.Edit
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
