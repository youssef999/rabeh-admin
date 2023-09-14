import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../bloc/admin/admin-states.dart';
import '../../../bloc/admin/admin_cubit.dart';
import '../../../const/app_message.dart';
import '../../../resources/color_manager.dart';
import '../../../widgets/Custom_Text.dart';
import '../../../widgets/Custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../admin_view.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        AdminCubit()..fetchCat(),
        child: BlocConsumer<AdminCubit, AdminStates>(

            listener: (context, state) {

              if(state is AddNewProductSuccessState){

                appMessage(text: 'تم اضافة المنتج بنجاح');

                Get.offAll(const AdminView());

              }
            },

            builder: (context, state) {

              AdminCubit cubit = AdminCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.white,
                appBar:AppBar(
                  elevation: 0,
                  toolbarHeight: 5,
                  backgroundColor:ColorsManager.primary,
                ),
                body:
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      children:  [
                        const SizedBox(height: 20,),


                        Container(
                            height: 140,
                            width: 600,
                            color:Colors.white,
                            child: Image.asset('assets/images/logo.png')),


                        const SizedBox(height: 20,),

                        (cubit.pickedImageXFiles != null
                            && cubit.pickedImageXFiles!.length>0)?
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                height:  MediaQuery.of(context).size.width*0.41,
                                width: MediaQuery.of(context).size.width*0.6,
                                decoration:BoxDecoration(
                                    image: DecorationImage(
                                        image:

                                        FileImage(
                                            File(cubit.pickedImageXFiles![0]
                                                .path)),

                                        fit:BoxFit.fill
                                    )
                                ),
                              ),
                              onTap:(){
                                cubit.pickMultiImage();
                              },
                            ),

                            const SizedBox(height: 31,),
                            const Divider(),
                            (cubit.pickedImageXFiles!.length>1)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![1].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>2)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![2].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>3)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![3].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>4)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![4].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),

                            (cubit.pickedImageXFiles!.length>5)?
                            Container(
                              height:  MediaQuery.of(context).size.width*0.41,
                              width: MediaQuery.of(context).size.width*0.6,
                              decoration:BoxDecoration(
                                  image: DecorationImage(
                                      image:FileImage(
                                          File(cubit.pickedImageXFiles![5].path)),
                                      fit:BoxFit.fill
                                  )
                              ),
                            ):const SizedBox(),
                          ],
                        ):

                        InkWell(
                          child: const Column(
                            children: [

                              CircleAvatar(
                                radius: 100,
                                child:Icon(Icons.image,size: 60,)
                              ),
                              SizedBox(height: 10,),
                              Custom_Text(text: 'اضف صورة ',color:Colors.black,
                                fontSize:21,alignment:Alignment.center,
                              ),
                            ],
                          ),
                          onTap:(){
                            cubit.pickMultiImage();
                          //  cubit.showDialogBox(context);
                          },
                        ),

                        const SizedBox(height: 20,),
                        CustomTextFormField(
                          controller:cubit.nameController,
                          color:Colors.black,
                          hint: "الاسم ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),
                        const SizedBox(height: 20,),
                        const Custom_Text(text: 'القسم ',color:Colors.black,
                          fontSize:21,alignment:Alignment.center,
                        ),
                        const SizedBox(height: 16,),
                        Center(
                          child: DropdownButton<String>(
                            value: cubit.selectedValue,
                            items: cubit.dataList.map((data) {
                              return DropdownMenuItem<String>(
                                value: data['name'].toString(),
                                child: Text(data['name']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              cubit.changeCatData(value!);

                            },
                            hint: const Text('Select an option'),
                          ),
                        ),



                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.desController,
                          color:Colors.black,
                          hint: "وصف المنتج ",
                          max: 6,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),

                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.price,
                          color:Colors.black,
                          hint: "سعر المنتح ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.number,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.priceVal,
                          color:Colors.black,
                          hint: "سعر العمولة علي هذا المنتج  ",
                          max: 2,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.number,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextFormField(
                          controller:cubit.ruleontroller,
                          color:Colors.black,
                          hint: " قواعد هذا المنتج  ",
                          max: 6,
                          obs: false,
                          obx: false,
                          ontap:(){},
                          type:TextInputType.text,
                        ),

                        const SizedBox(height: 20,),
                        CustomButton(text: "اضافة",
                            onPressed: (){
                          if(cubit.wait==false){
                            cubit.addDataToFireBase();
                          }else{
                            appMessage(text: 'قيد التحميل') ;
                          }
                            }, color1:ColorsManager.primary,
                            color2: Colors.white),
                        const SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}