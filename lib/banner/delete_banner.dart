import 'package:admin_gokul/config/config.dart';
import 'package:admin_gokul/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DeleteBanner extends StatefulWidget {
  String id;
  String url;
   DeleteBanner({Key? key,required this.id,required this.url}) : super(key: key);

  @override
  State<DeleteBanner> createState() => _DeleteBannerState();
}

class _DeleteBannerState extends State<DeleteBanner> {
  void deleteProduct(String productId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Banner').doc(productId).delete();

      print('Product deleted successfully');
      // Navigator.pop(context); // Close the dialog after deletion
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Banner"),
      ),
      body: Stack(
        children: [
          Opacity(
              opacity: MyConfig.opacity,
              child: Image.asset(MyConfig.bg,fit: BoxFit.fill,height: double.infinity ,width: double.infinity)),

          Center(
            child: IconButton(
              onPressed: () async {
                deleteProduct(widget.id);
                await FirebaseStorage.instance.refFromURL(widget.url).delete().then((value) => print("delete"));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePge(),));
                },
              icon: const Icon(Icons.delete,size: 30,),
            ),
          ),
        ],
      ),
    );
  }
}
