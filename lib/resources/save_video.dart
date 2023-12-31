import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadVideo(String videoURL) async {
    Reference ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoURL));
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> saveVideoData(String videoDownloadURL) async {
    await _fireStore.collection('videos').add({
      'url': videoDownloadURL,
      'timeStamp': FieldValue.serverTimestamp(),
      'name': 'User Video'
    });
  }
}
