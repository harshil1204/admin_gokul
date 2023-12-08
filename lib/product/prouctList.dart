import 'package:admin_gokul/product/updateProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

class ProductList extends StatefulWidget {
String cat_id;
   ProductList({Key? key,required this.cat_id}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}



class _ProductListState extends State<ProductList> {

  void deleteProduct(String productId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('Products').doc(productId).delete();

      print('Product deleted successfully');
      Navigator.pop(context); // Close the dialog after deletion
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct(catId: widget.cat_id)));
          }, icon: Icon(Icons.add)
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('Products').where('id', isEqualTo: widget.cat_id).get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              print(snapshot.data!.docs);
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,crossAxisSpacing:8,mainAxisSpacing: 8
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateProduct(snapShot: snapshot.data!.docs[index],id: snapshot.data!.docs[index].id),));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(9)
                            ),
                            child: Column(
                              children: [
                                SizedBox(height:83,child: Image.network(snapshot.data!.docs[index]['url'].toString(),fit: BoxFit.fill)),
                                Container(
                                  width: double.infinity,
                                  //padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10),
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(9),bottomLeft: Radius.circular(9))
                                  ),
                                  child: Column(
                                    children: [
                                      Text("name:${snapshot.data!.docs[index]['name'].toString() ?? ''}",maxLines: 1,style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.white
                                      ),),
                                      Text("Weight:${snapshot.data!.docs[index]['price'].toString() ?? ''}",style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.white
                                      ),),
                                      Text("extra:${snapshot.data!.docs[index]['extra'].toString() ?? ''}",style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.white
                                      ),),
                                      InkWell(
                                        onTap: (){
                                          deleteProduct(snapshot.data!.docs[index].id.toString());
                                        },
                                        child: Icon(Icons.delete,),
                                      ),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}
