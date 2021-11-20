abstract class SocialLayoutStates {}

class SocialInitialState extends SocialLayoutStates{}
class SocialGetUserLoadingState extends SocialLayoutStates{}

class SocialGetUserSuccessState extends SocialLayoutStates{}

class SocialGetUserErrorState extends SocialLayoutStates{
  final error;

  SocialGetUserErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialLayoutStates{}

class SocialGetPostsSuccessState extends SocialLayoutStates{}

class SocialGetPostsErrorState extends SocialLayoutStates{
  final error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialLayoutStates{}

class SocialLikePostErrorState extends SocialLayoutStates{
  final error;

  SocialLikePostErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialLayoutStates{}

class SocialGetAllUsersSuccessState extends SocialLayoutStates{}

class SocialGetAllUsersErrorState extends SocialLayoutStates{
  final error;

  SocialGetAllUsersErrorState(this.error);
}


class SocialChangeNavButtonSuccessState extends SocialLayoutStates{}

class SocialAddPostsSuccessState extends SocialLayoutStates{}

class SocialProfileImagePickedSuccessState extends SocialLayoutStates{}

class SocialProfileImagePickedErrorState extends SocialLayoutStates{}

class SocialCoverImagePickedSuccessState extends SocialLayoutStates{}

class SocialCoverImagePickedErrorState extends SocialLayoutStates{}

class SocialUploadImageSuccessState extends SocialLayoutStates{}

class SocialUploadImageErrorState extends SocialLayoutStates{}

class SocialUploadCoverSuccessState extends SocialLayoutStates{}

class SocialUploadCoverErrorState extends SocialLayoutStates{}

class SocialUploadUserLoadingState extends SocialLayoutStates{}

class SocialUploadUserErrorState extends SocialLayoutStates{}

// create post

class SocialUploadPostLoadingState extends SocialLayoutStates{}

class SocialUploadPostSuccessState extends SocialLayoutStates{}

class SocialUploadPostErrorState extends SocialLayoutStates{}

class SocialUploadPostImageSuccessState extends SocialLayoutStates{}

class SocialUploadPostImageErrorState extends SocialLayoutStates{}

class SocialCreatePostSuccessState extends SocialLayoutStates{}

class SocialCreatePostErrorState extends SocialLayoutStates{}

class SocialRemovePostImageState extends SocialLayoutStates{}

// chats

class SocialSentMessageSuccessState extends SocialLayoutStates{}

class SocialSentMessageErrorState extends SocialLayoutStates{}

class SocialGetMessageSuccessState extends SocialLayoutStates{}

class SocialGetMessageErrorState extends SocialLayoutStates{}