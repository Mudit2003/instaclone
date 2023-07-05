import 'package:instaclone/models/cloud/cloud_user.dart';

class AuthUserProfile {
  static UserProfile? _profile; // this profile can be set
  // this as a static variable will never ever be instantiated again after first instantiation
  set profileSetter(UserProfile? currProfile) {
    _profile = currProfile;
  }

  UserProfile? get profileGetter {
    return _profile;
  }
}
