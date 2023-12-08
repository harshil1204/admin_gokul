import 'package:admin_gokul/category/updateCat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddCat()));
          },
              icon: const Icon(Icons.add))
        ],
      ),
      body:  FutureBuilder(
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
                        padding:  const EdgeInsets.symmetric(vertical: 4.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCat(id:snapshot.data!.docs[index].id,name:snapshot.data!.docs[index]['name'] ),));
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
        return const Center(child: CircularProgressIndicator(color: Colors.grey,));
      }
        },
      ),
    );
  }
}