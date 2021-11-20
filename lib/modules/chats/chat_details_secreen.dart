import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:social_app1/layout/cubit/states.dart';
import 'package:social_app1/models/message_model.dart';
import 'package:social_app1/models/user_model.dart';
import 'package:social_app1/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  var chatTextController = TextEditingController();

  SocialUserModel? userModel;

  ChatDetailsScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {

        SocialHomeCubit.get(context).getMessageChat(receiverId: userModel!.uId);

        return BlocConsumer<SocialHomeCubit, SocialLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text('${userModel!.name}'),
                  ],
                ),
              ),
              body: Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                  SocialHomeCubit.get(context).messages.length > 0,
                  widgetBuilder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                              SocialHomeCubit.get(context).messages[index];
                              if (SocialHomeCubit.get(context).userModel!.uId == message.senderId)
                                return builtMyMessage(message);

                              return builtMessage(message);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15.0,
                            ),
                            itemCount:
                            SocialHomeCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: chatTextController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type Your Message Here ....'),
                                ),
                              ),
                              Container(
                                color: Theme.of(context).primaryColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialHomeCubit.get(context).sendMessage(
                                        receiverId: userModel!.uId,
                                        dateTime: DateTime.now(),
                                        text: chatTextController.text);
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallbackBuilder: (context) =>
                      Center(child: CircularProgressIndicator())),
            );
          },
        );
      },
    );
  }

  Widget builtMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          child: Text('${model.text}'),
        ),
      );

  Widget builtMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.2),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          child: Text('${model.text}'),
        ),
      );
}
