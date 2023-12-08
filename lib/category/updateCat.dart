import 'package:admin_gokul/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'categoryList.dart';

class UpdateCat extends StatefulWidget {
  String id;
  String name;
   UpdateCat({Key? key,required this.id,required this.name}) : super(key: key);

  @override
  State<UpdateCat> createState() => _UpdateCatState();
}

class _UpdateCatState extends State<UpdateCat> {
  void updateCatDetails(String catName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Categories').doc(widget.id).update({
        'name': catName,
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryList(),));
      print('CAtegory details updated successfully');
    } catch (e) {
      print('Error updating product details: $e');
    }
  }
  @override
  void initState() {
    _categoryController.text=widget.name;
    // TODO: implement initState
    super.initState();
  }
  final TextEditingController _categoryController = TextEditingController();
  void deleteCat(String catId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Categories').doc(catId).delete();
      print('Categories deleted successfully');
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePge(),)); // Close the dialog after deletion
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Category"),
        actions: [
          IconButton(onPressed:(){
            deleteCat(widget.id);
          } ,icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: _categoryIdController,
            //   decoration: const InputDecoration(
            //     labelText: 'Category id',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String categoryName = _categoryController.text.trim();
                if (categoryName.isNotEmpty) {
                  updateCatDetails(categoryName);
                  _categoryController.clear();
                }
              },
              child: const Text('Update Category'),
            ),
          ],
        ),
      ),
    );
  }
}
