import 'package:admin_gokul/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCat extends StatefulWidget {
  const AddCat({Key? key}) : super(key: key);
  @override
  State<AddCat> createState() => _AddCatState();
}

class _AddCatState extends State<AddCat> {
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();


  void addCategoryToFirestore(String categoryName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Categories').add({
        'name': categoryName,
        // Add more fields related to the category if needed
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePge(),));
      SnackBar(content: Text("Category added successfully"),);
      print('Category added successfully');
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
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
                  addCategoryToFirestore(categoryName);
                  _categoryController.clear();
                }
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
