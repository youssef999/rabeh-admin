


 import 'dart:convert';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';

class SendNotificationsView extends StatelessWidget {
  const SendNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController title=TextEditingController();
    TextEditingController body=TextEditingController();

    return  Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.black,
        leading:IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body:Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          children: [
            const SizedBox(height: 73,),
            CustomTextFormField(hint: 'العنوان',
                obx: false, ontap: (){

                }, type: TextInputType.text, obs: false, color: Colors.black,

                controller: title),
            const SizedBox(height: 21,),

            CustomTextFormField(hint: 'محتوي الاشعار',
                obx: false, ontap: (){

                }, type: TextInputType.text, obs: false, color: Colors.black,

                controller: body),
            const SizedBox(height: 21,),
            CustomButton(text: 'ارسال الاشعارات الان ',
                onPressed: (){

              fetcTokens().then((value) {
                sendNotificationNow(token: tokens, title: title.text, body: body.text);
                Get.offAll(const AdminView());

              });
                }, color1:Colors.black, color2: Colors.white)
          ],
        ),
      ),
    );
  }
}
 List<Map<String, dynamic>>tokenist = [];
 List<String>tokens = [];

 Future<void> fetcTokens() async {

   print("MINNN");
   try {
     QuerySnapshot querySnapshot =
     await FirebaseFirestore.instance.collection('tokens').get();

     try{
       List<Map<String, dynamic>> data

       = querySnapshot.docs.map((DocumentSnapshot doc) =>
       doc.data() as Map<String, dynamic>).toList();


        tokenist = data;
         for(int i=0;i<tokenist.length;i++){
           tokens.add(tokenist[i]['token'].toString());
         }
         print("TOKENS"+tokens[0]);

     }catch(e){
       print("E.......");
       print(e);
       print("E.......");
     }
   }
   catch (error) {
     print("Error fetching data: $error");
   }
 }



 sendNotificationNow
     ({required List token,required String title,required String body}) async

 {
   var responseNotification;
   Map<String, String> headerNotification =
   {
     'Content-Type': 'application/json',
     'Authorization':
     'key=AAAA91_AArE:APA91bGEiGL8ZWZfusMpn9b_V64nhLgz8ZuSLoVV-wQW8t1LUOSW7FCqYRT2q5EEGgA1wd2WBjbGWPc6ZxITAZ9H_nWLe9hkyKKFOmmMwYQF2RTW-2IkZ_b_2UK5KNzr-wCsOuBrX_4L'
   };
   Map bodyNotification =
   {
     "body":body,
     "title":title
   };

   Map dataMap =
   {
     "click_action": "FLUTTER_NOTIFICATION_CLICK",
     "id": "1",
     "status": "done",
     //   "rideRequestId": docId
   };




   for(int i=0;i<token.length;i++){
     Map officialNotificationFormat =
     {
       "notification": bodyNotification,
       "data": dataMap,
       "priority": "high",
       "to": token[i],
     };


     try{
       print('try send notification');
       responseNotification = http.post(
         Uri.parse("https://fcm.googleapis.com/fcm/send"),
         headers: headerNotification,
         body: jsonEncode(officialNotificationFormat),
       ).then((value) {
         print('NOTIFICATION SENT ==$value');
       });
     }
     catch(e){
       print("NOTIFICATION ERROR===$e");
     }
   }

   return   responseNotification;

 }