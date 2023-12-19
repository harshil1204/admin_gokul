import 'package:admin_gokul/config/config.dart';
import 'package:admin_gokul/product/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateGold extends StatefulWidget {
  String id;
  String name;
  String price;
  String karet;
   UpdateGold({Key? key,required this.id,required this.name,required this.price,required this.karet}) : super(key: key);

  @override
  State<UpdateGold> createState() => _UpdateGoldState();
}

class _UpdateGoldState extends State<UpdateGold> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productKaretController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  void updateProductDetails(String productName,String price,String karet) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('GoldPrice').doc(widget.id).update({
        'name': productName,
        'price': price,
        'karet': karet,
        'time':DateTime.now()
        // Add more fields to update if needed
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageProduct(),));
      print('Product details updated successfully');
    } catch (e) {
      print('Error updating product details: $e');
    }
  }

  @override
  void initState() {
    _productNameController.text=widget.name;
    _productPriceController.text=widget.price;
    _productKaretController.text=widget.karet;
    super.initState();
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
                        updateProductDetails(productName,productPrice,productKaret);
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
