class SocialUserModel {
  String? name;
  String? email;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  String? phone;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.uId,
    this.bio,
    this.image,
    this.cover,
    this.phone,
    this.isEmailVerified
});

  SocialUserModel.fromJson(Map<String , dynamic> json){
    name = json['name'];
    email = json['name'];
    uId = json['uId'];
    phone = json['phone'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String , dynamic> toMap() {
    return {
      'name':name,
      'email':email,
      'uId':uId,
      'phone':phone,
      'bio':bio,
      'image':image,
      'cover':cover,
      'isEmailVerified':isEmailVerified
    };
  }
}