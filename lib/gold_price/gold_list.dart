import 'package:admin_gokul/config/config.dart';
import 'package:admin_gokul/gold_price/add_gold.dart';
import 'package:admin_gokul/gold_price/update_gold.dart';
import 'package:admin_gokul/resources/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
class GoldMain extends StatefulWidget {
  const GoldMain({Key? key}) : super(key: key);

  @override
  State<GoldMain> createState() => _GoldMainState();
}

class _GoldMainState extends State<GoldMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gold price list"),
        actions: [
          IconButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGold()));
          }, icon: const Icon(Icons.add)
          )
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('GoldPrice').get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Stack(
            children: [
              Opacity(
                  opacity: MyConfig.opacity,
                  child: Image.asset(MyConfig.bg,fit: BoxFit.fill,height: double.infinity,width: double.infinity )),
              SizedBox(
                height: 145,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    Timestamp dateString = data['time'];
                    // Convert the Firebase Timestamp to a DateTime object
                    DateTime dateTime = dateString.toDate();
                    String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateGold(id: data.id,name: data['name'],karet: data['karet'],price: data['price'],)));
                      },
                      child: Container(
                        height: 135,
                        width: 150,
                        decoration: BoxDecoration(
                            boxShadow:  const [
                              BoxShadow(
                                  color: AppColor.white,
                                  blurRadius: 0.6,
                                  spreadRadius: 0.9
                              )
                            ],
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(20),
                              const Divider(
                                color: AppColor.black,
                                height: 2,
                                thickness: 4,
                                endIndent: 30,
                              ),
                              const Gap(6),
                              Text(data['name'],style: const TextStyle(
                                  color: AppColor.textDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                              const Gap(5),
                              Text(data['karet'],style: const TextStyle(
                                  color: AppColor.textDark,
                                  fontSize: 10
                              ),),
                              const Gap(5),
                              Text("₹ ${data['price']}",style: const TextStyle(
                                  color: AppColor.textDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19
                              ),),
                              const Gap(9),
                               Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Last updated on",style: TextStyle(
                                      color: AppColor.textLight,
                                      fontSize: 12
                                  ),),

                                  Text(formattedDate,style: const TextStyle(
                                      color: AppColor.textLight,
                                      fontSize: 12
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
