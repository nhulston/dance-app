import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');
  static CollectionReference videos = FirebaseFirestore.instance.collection('videos');

  /// Gets user doc
  static DocumentReference getUserDoc() {
    User user = FirebaseAuth.instance.currentUser!;
    return users.doc(user.uid);
  }

  /// Updates user skill level on the database
  static void updateSkillLevel(int level) {
    // 0 = beginner, 1 = intermediate, 2 = advanced
    if (level < 0 || level > 2) {
      throw ArgumentError('Experience level must be in range 0-2');
    }

    log('[DB updateSkillLevel] Attempting to update user skill level in database to $level');
    getUserDoc().set({'skill': level,})
        .then((value) => log('[DB updateSkillLevel] Successfully updated user skill level in database to $level'))
        .catchError((error) => log('[DB updateSkillLevel] Failed to update skill level in database: $error'));
  }

  /// Get skill level from database
  static Future<int> getSkillLevel() async {
    return (await getUserDoc().get())['skill'];
  }

  /// Get stream of videos
  static Stream<QuerySnapshot<Object?>> getVideos() {
    return videos.snapshots();
  }
}