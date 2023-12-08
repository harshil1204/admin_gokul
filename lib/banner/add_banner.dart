import 'package:admin_gokul/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AddBanner extends StatefulWidget {
  const AddBanner({Key? key}) : super(key: key);
  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  String? imageUrl;
  void addBannerToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Banner').add({
      'url':imageUrl,
        // Add more fields related to the category if needed
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePge(),));
      SnackBar(content: Text("Category added successfully"),);
      print('Category added successfully');
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    DateTime now =  DateTime.now();
    // var datestamp = DateFormat("yyyyMMdd'T'HHmmss");
    // String currentdate = datestamp.format(now);

    //Select Image
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null){
      //Upload to Firebase
      var snapshot = await _firebaseStorage.ref()
          .child('banner/$now.jpg')
          .putFile(File(image.path));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      print('No Image Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Banner"),
        actions: [
          InkWell(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ,));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  // height: 130,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: Colors.white),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: (imageUrl == null)
                        ? const Icon(Icons.photo)
                        : Image.network(imageUrl.toString(),height: 300,width:double.infinity,fit: BoxFit.fill,)
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (imageUrl!.isNotEmpty) {
                    addBannerToFirestore();
                    imageUrl="";
                  }
                },
                child: const Text('Add Banner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
