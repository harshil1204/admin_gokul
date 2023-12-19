import 'package:admin_gokul/config/config.dart';
import 'package:admin_gokul/product/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddGold extends StatefulWidget {
  const AddGold({Key? key}) : super(key: key);

  @override
  State<AddGold> createState() => _AddGoldState();
}

class _AddGoldState extends State<AddGold> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productKaretController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  void addProductToFirestore(String productName,String productPrice,String karet) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('GoldPrice').add({
        'name': productName,
        'price':productPrice,
        'karet':karet,
        'time': DateTime.now(),
        // Add more fields related to the category if needed
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPageProduct(),));
      print('Product added successfully');
    } catch (e) {
      print('Error adding category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Gold price "),
      ),
      body: Stack(
        children: [
          Opacity(
              opacity: MyConfig.opacity,
              child: Image.asset(MyConfig.bg,fit: BoxFit.fill,height: double.infinity ,width: double.infinity,)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _productKaretController,
                    // keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'karet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _productPriceController,
                    // keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      String productName = _productNameController.text.trim();
                      String productPrice = _productPriceController.text.trim();
                      String productKaret = _productKaretController.text.trim();
                      //uploadImage();
                      if (productName.isNotEmpty && productPrice.isNotEmpty &&  productKaret.isNotEmpty) {
                        addProductToFirestore(productName,productPrice,productKaret);
                        _productNameController.clear();
                        _productPriceController.clear();
                        _productKaretController.clear();
                      }
                    },
                    child: const Text('Add Data'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
