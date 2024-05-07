// flutter_fly.dart from flutter_fly video,
// https://www.youtube.com/watch?v=y8CaaUWa8Lk&list=PLJh8Hi_cW8DYL931ALm3StESuee5oFWze&index=8&t=169s&ab_channel=FlutterFly
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String? imageUrl;
  final ImagePicker _imagePicker = ImagePicker();
  bool isLoading=false;
  pickImage()async{
    XFile? res= await _imagePicker.pickImage(source: ImageSource.camera); // ImageSource.camera / gallery
    if(res!=null){
      uploadToFirebase(File(res.path)); // <--- image file
    }
  }

  uploadToFirebase(image) async{
    isLoading=true;
    setState(() {});
    try {
      Reference sr = FirebaseStorage.instance.ref() //storage Reference
          .child("pictures/${DateTime.now().millisecondsSinceEpoch}.png");
      await sr.putFile(image).whenComplete(() => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image uploaded to 🔥Firebase"),
          duration: Duration(seconds: 3),
          ),
        ),
      });
      imageUrl = await sr.getDownloadURL();
    } catch (e) {
      print("error occurred: $e");
    }
    isLoading=false;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            imageUrl==null?
                const Icon(Icons.person,size: 150,color: Colors.grey,):
                Center(
                  child: Image.network(imageUrl!,
                    height: 200, //<------------- 9:30
                    fit: BoxFit.contain,
                  ),
                ),
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton.icon(
                onPressed: (){
                  pickImage();
                },
                icon: const Icon(Icons.image),
                label: const Text('Upload Image',style: TextStyle(fontSize: 20),),
              ),
            ),
            const SizedBox(height: 10,),
            //if(isLoading)const CircularProgressIndicator(),
            if(isLoading)const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
