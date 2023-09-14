

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/views/admin/products/product_details.dart';
import 'package:shop_app/presentation/views/admin/products/products_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class ChooseCountryView extends StatelessWidget {
  const ChooseCountryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:ListView(
        children: [
          CountryWidget()
        ],
      ),
    );
  }
}

Widget CountryWidget() {
  return SizedBox(
    height: 12200,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('countries')
        //.where('country',isNotEqualTo: '')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 4,
                      childAspectRatio:0.85
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data!.docs[index];
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      child: Hero(
                        tag: 'img$index',
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                color:ColorsManager.primary2
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  child:  Image.network(posts['img'],fit:BoxFit.fitWidth,),),



                                const SizedBox(
                                  height: 5,
                                ),

                                const SizedBox(height: 2,),

                                Custom_Text(text: posts['name'],fontSize:17,alignment:Alignment.center,
                                  fontWeight:FontWeight.bold,
                                ),
                                const SizedBox(height: 22,),
                                CustomButton(text:' التالي ', onPressed:(){
                                  Get.to(ProductsView(
                                    //country: posts['name'],
                                  ));
                                }, color1:ColorsManager.primary, color2:ColorsManager.primary2)
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap:(){
                      },
                    );
                  });
          }
        }),
  );
}

