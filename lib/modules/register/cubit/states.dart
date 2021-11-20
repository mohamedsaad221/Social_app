
abstract class SocialRegisterStates {}

class SocialRegisterInitial extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final error;
  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final error;
  SocialCreateUserErrorState(this.error);
}

class SocialRegisterPasswordVisibility extends SocialRegisterStates {}