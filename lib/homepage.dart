import 'package:admin_gokul/category/add_category.dart';
import 'package:admin_gokul/config/config.dart';
import 'package:admin_gokul/gold_price/gold_list.dart';
import 'package:admin_gokul/product/mainpage.dart';
import 'package:flutter/material.dart';

import 'banner/add_banner.dart';
import 'banner/banner_list.dart';
import 'category/categoryList.dart';

class HomePge extends StatefulWidget {
  const HomePge({Key? key}) : super(key: key);

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin panel"),
      ),
      body: Stack(
        children: [
          Opacity(
              opacity: MyConfig.opacity,
              child: Image.asset(MyConfig.bg,fit: BoxFit.fill,height: double.infinity )),
          Center(
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GoldMain(),));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child:  Text("Add Gold Price",
                        style: TextStyle(fontSize: 17,color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(height: 10),InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const BannerListPage(),));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child:  Text("Add Banner",
                        style: TextStyle(fontSize: 17,color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryList(),));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child:  Text("Add Category",
                      style: TextStyle(fontSize: 17,color: Colors.white),
                      )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPageProduct(),));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child:  Text("Add Product",
                      style: TextStyle(fontSize: 17,color: Colors.white),
                      )),
                    ),
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
