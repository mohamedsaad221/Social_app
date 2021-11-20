import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/modules/chats/chat_details_secreen.dart';
import 'package:social_app1/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialHomeCubit , SocialLayoutStates>(
      listener: (context , state) {},
      builder: (context , state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => SocialHomeCubit.get(context).users.length > 0,
          widgetBuilder: (context) => ListView.separated(
              itemBuilder: (context, index) => builtChatItem(SocialHomeCubit.get(context).users[index], context),
              separatorBuilder: (context , index) => myDivider(),
              itemCount: SocialHomeCubit.get(context).users.length
          ),
          fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builtChatItem(SocialUserModel model , context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
