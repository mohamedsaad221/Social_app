import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/post_model.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit, SocialLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: Conditional.single(
              context: context,
              conditionBuilder: (context) => SocialHomeCubit.get(context).userModel != null,
              widgetBuilder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(
                              'https://i.imgur.com/8qA4rd2.jpg',
                            ),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'communicate with friends',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostsItem(SocialHomeCubit.get(context).posts[index], context , index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                      itemCount: SocialHomeCubit.get(context).posts.length,
                    ),
                  ],
                ),
              ),
              fallbackBuilder: (context) => Center(child: CircularProgressIndicator())
          )
        );
      },
    );
  }

  Widget buildPostsItem(PostModel model ,context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10.0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
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
                          '${model.name}',
                          style: TextStyle(height: 1.3),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          size: 15.0,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.3),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 17.0,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0
                  ),
                  child: Container(
                    height: 25.0,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.5,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#software',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0
                  ),
                  child: Container(
                    height: 25.0,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                      ),
                      child: Container(
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: 1.5,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '#flutter',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.only(
              top: 10.0
            ),
            child: Container(
              height: 160.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${model.postImage}',
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      children: [
                        Icon(IconBroken.Heart,color: Colors.red,size: 17.0,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '0',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Chat,color: Colors.amber,size: 17.0,),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '0 comments',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 17.0,
                          backgroundImage: NetworkImage(
                            '${SocialHomeCubit.get(context).userModel!.image}',
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Text(
                            'write a comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        SocialHomeCubit.get(context).likePost(SocialHomeCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children: [
                          Icon(Icons.share,size: 16.0,color: Colors.amber,),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Share',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
