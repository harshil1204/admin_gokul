import 'package:admin_gokul/product/add_product.dart';
import 'package:admin_gokul/product/prouctList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainPageProduct extends StatefulWidget {
  const MainPageProduct({Key? key}) : super(key: key);

  @override
  State<MainPageProduct> createState() => _MainPageProductState();
}

class _MainPageProductState extends State<MainPageProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Categories').get(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:snapshot.data!.docs.length ?? 0,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()
                      ),
                      itemBuilder:(context, index) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 4.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList(cat_id: snapshot.data!.docs[index].id.toString()),));
                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child:  SizedBox(
                                height: 60,width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data!.docs![index]['name'].toString() ?? " ",maxLines: 1,style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
