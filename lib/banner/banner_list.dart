import 'package:admin_gokul/banner/add_banner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class BannerListPage extends StatefulWidget {
  const BannerListPage({super.key});

  @override
  State<BannerListPage> createState() => _BannerListPageState();
}

class _BannerListPageState extends State<BannerListPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Banner"),
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBanner(),));
              },
              child: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Banner').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCat(id:snapshot.data!.docs[index].id,name:snapshot.data!.docs[index]['name'] ),));
                            },
                            child: Card(
                              elevation: 5,
                              //color: Colors.grey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child:  CachedNetworkImage(
                                imageUrl: snapshot.data!.docs![index]['url'],
                                fit: BoxFit.fill,
                                height: 300,width: double.infinity,
                                placeholder: (context, url) => const Center(child: CupertinoActivityIndicator(color: Colors.grey,),),
                              )
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
