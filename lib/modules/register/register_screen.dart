import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social_app1/layout/social_layout.dart';
import 'package:social_app1/modules/register/cubit/cubit.dart';
import 'package:social_app1/modules/register/cubit/states.dart';
import 'package:social_app1/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
          listener: (context, state) {
            if (state is SocialCreateUserSuccessState) {
              navigateAndFinish(context, SocialLayout());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Register',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Register now to communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 30.0,
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
                              prefixIcon: Icons.person,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'email must be not empty';
                                }
                                return null;
                              },
                              labelText: 'Email Address',
                              prefixIcon: Icons.email,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                                controller: passwordController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'email must be not empty';
                                  }
                                  return null;
                                },
                                labelText: 'Password',
                                isPassword:
                                    SocialRegisterCubit.get(context).isPassword,
                                prefixIcon: Icons.lock_outline,
                                suffixIcon:
                                    SocialRegisterCubit.get(context).suffix,
                                suffixPressed: () =>
                                    SocialRegisterCubit.get(context)
                                        .changePasswordVisibility()),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'phone must be not empty';
                                }
                                return null;
                              },
                              labelText: 'phone',
                              prefixIcon: Icons.phone,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                                  state is! SocialRegisterLoadingState,
                              widgetBuilder: (context) =>
                                  defaultTextMaterialButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context)
                                        .userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Register',
                                colorText: Colors.white,
                              ),
                              fallbackBuilder: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
