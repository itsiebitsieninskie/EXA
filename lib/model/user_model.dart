class UserModel {
  final String email;
  final String password;
  final ProfileModel profile;

  UserModel({
    required this.email,
    required this.password,
    required this.profile,
  });

  toJson() {
    return {
      "Email": email,
      "Password": password,
      "Profile": profile.toJson(),
    };
  }
}

class ProfileModel {
  final String followers;
  final String watchtime;
  final String badges;

  ProfileModel({
    required this.followers,
    required this.watchtime,
    required this.badges,
  });

  toJson() {
    return {
      "Followers": followers,
      "Watchtime": watchtime,
      "Badges": badges,
    };
  }
}
