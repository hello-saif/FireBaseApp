// implemented correctly in app2_fire_storage app
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  //The first step in accessing your Cloud Storage bucket is to create an instance of FirebaseStorage:
  //https://firebase.google.com/docs/storage/flutter/start#set_up_public_access
  final FirebaseStorage storage = FirebaseStorage.instance;
  //Create a Cloud Storage reference on Flutter
  //https://firebase.google.com/docs/storage/flutter/create-reference
  final Reference storageRef = FirebaseStorage.instance.ref(); // <- Points to the root reference
  final Reference imagesRef = FirebaseStorage.instance.ref().child("pictures"); // not storageRef // <- Points to "pictures"
  final Reference spaceRef = FirebaseStorage.instance.ref().child("pictures/star pic.png"); // not storageRef.child("pictures/star pic.png.jpg");
  //final imagesRef2 = spaceRef.parent; //The instance member 'spaceRef' can't be accessed in an initializer. (Documentation)
  //final imagesRef3 = spaceRef.root; //The instance member 'spaceRef' can't be accessed in an initializer. (Documentation)
  //accessing root.parent results in null.
  //Reference Properties: spaceRef.name; spaceRef.bucket; spaceRef.fullPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('title'),backgroundColor: Colors.blue,),
      body: const Center(child: Text('Hello'),),
    );
  }
}
