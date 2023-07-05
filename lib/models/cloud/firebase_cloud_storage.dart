import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/models/cloud/auth_cloud_constatnts.dart';
import 'package:instaclone/models/cloud/cloud_user.dart';

class FirebaseCloud {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<bool> isUserNamePossible({required String username}) async {
    bool flag = true;
    try {
      await _users
          .where(userNameField, isEqualTo: username)
          .get()
          .then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
          if (doc.exists) {
            flag = false;
            break;
          }
        }
      });
    } on Exception catch (e) {
      log("Error In Caching Username: ${e.toString()}");
    }
    return flag;
  }

  Future<void> createNewUserProfile({
    required UserProfile profile,
    required String uId,
  }) async {
    if (await isUserNamePossible(username: profile.userName)) return;
    try {
      await _users.doc().set(<String, dynamic>{
        nameField: profile.name,
        userNameField: profile.userName,
        ownerBioField: profile.bio,
        followerField: profile.followers,
        followingField: profile.followings,
      });
    } on Exception catch (e) {
      log("Exception in creating new profile: ${e.toString()}");
    }
  }

  Future<UserProfile?> profileExists({required String userId}) async {
    return await _users.doc(userId).get().then((value) {
      if (value.exists) {
        return UserProfile.fromSnapshot(snapshot: value);
      } else {
        return null;
      }
    });
  }

  static final FirebaseCloud _shared = FirebaseCloud.sharedInstance();
  FirebaseCloud.sharedInstance();
  factory FirebaseCloud() => _shared;
}
