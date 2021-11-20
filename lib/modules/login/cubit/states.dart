
abstract class SocialLoginStates {}

class SocialLoginInitial extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginPasswordVisibility extends SocialLoginStates {}

class SocialLoginErrorState extends SocialLoginStates {
  final error;
  SocialLoginErrorState(this.error);
}

