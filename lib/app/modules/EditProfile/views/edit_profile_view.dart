import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1, //
        flexibleSpace: Container(
          height: Get.height * 0.2,
          color: Color(0xff0264C5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 10, bottom: 10,right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image:
                                AssetImage("assets/images/back.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Edit Profile",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      GetBuilder<EditProfileController>(
                          builder: (controller) {
                            return GestureDetector(
                              onTap:(){
                                controller.selectFile();
                              },
                              child: Container(
                                height: Get.height*0.1,
                                width: Get.width*0.18,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                ),
                                child: controller.isPicked.value ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.file(controller.imageFile!,fit: BoxFit.fill,)): Image(image: AssetImage("assets/images/NoPath.png")),
                              ),
                            );
                          }
                      ),
                      Positioned(
                        bottom: 14,
                        right: -1,
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Get.height*0.02,
                            width: Get.width*0.06,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 10,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  w(15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kevin Zegers",style: TextStyle(fontSize: 18),),
                      h(5),
                      Row(
                        children: [
                          Text("25 Old |",style: TextStyle(fontSize: 12),),
                          Text("Dieppe, Canada.",style: TextStyle(fontSize: 12),),
                        ],
                      )
                    ],
                  ),

                ],
              ),
              h(20),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_name.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              InputTextField(
                borderColor: Colors.grey,
                borderRadius: 10,
                hintTextStyle: TextStyle(color: Colors.grey),
                context: context,
                controller: controller.Name,
                hintText: "Kevin Zegers",
              ),
             h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_email.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              InputTextField(
                borderColor: Colors.grey,
                borderRadius: 10,
                hintTextStyle: TextStyle(color: Colors.grey),
                context: context,
                controller: controller.Name,
                hintText: "Kevin@email.com",
              ),
              h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_phone.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              InputTextField(
                borderColor: Colors.grey,
                borderRadius: 10,
                hintTextStyle: TextStyle(color: Colors.grey),
                context: context,
                controller: controller.Name,
                hintText: "+1 985 547 2222",
              ),
              h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_Your_Location.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              InputTextField(
                borderColor: Colors.grey,
                borderRadius: 10,
                hintTextStyle: TextStyle(color: Colors.grey),
                context: context,
                controller: controller.Name,
                hintText: "Dieppe, Canada.",
              ),
              h(25),
              Row(
                children: [
                  Text((LocaleKeys.labels_Children_information.tr),style: TextStyle(fontSize: 18,color: Colors.black),),
                  Spacer(),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: Get.height*0.04,
                      width: Get.width*0.08,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add,color: Colors.white,),
                    ),
                  ),
                ],
              ),
              h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_children.tr + " " +LocaleKeys.labels_name.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InputTextField(
                    width: Get.width*0.75,
                    borderColor: Colors.grey,
                    borderRadius: 10,
                    hintTextStyle: TextStyle(color: Colors.grey),
                    context: context,
                    controller: controller.Name,
                    hintText: "Zoe Saldana",
                  ),
                  Container(
                      height: Get.height*0.03,
                      width: Get.width*0.06,
                      child: Image(image: AssetImage("assets/images/delete.png"))),
                ],
              ),
              h(15),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text((LocaleKeys.labels_children.tr + " " + LocaleKeys.labels_age.tr),style: TextStyle(fontSize: 16),)),
              h(5),
              InputTextField(
                width: Get.width*0.75,
                borderColor: Colors.grey,
                borderRadius: 10,
                hintTextStyle: TextStyle(color: Colors.grey),
                context: context,

                controller: controller.Name,
                hintText: "6 Years",
              ),
              h(30),
              ButtonWithStyle(
                onPressed: () {

                },
                textVal: LocaleKeys.buttons_save.tr.toUpperCase(),
                btnwidth: Get.width,
              ),
              h(90),
              // GetBuilder<EditProfileController>(builder: (_) {
              //   return ListView.separated(
              //     separatorBuilder: (context, index) => h(20),
              //     itemCount: controller.weekPrice.length + 1,
              //     padding: EdgeInsets.zero,
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Expanded(
              //               flex: 2,
              //               child: index == 0
              //                   ? Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   InputTextField(
              //                     width: Get.width*0.75,
              //                     borderColor: Colors.grey,
              //                     borderRadius: 10,
              //                     hintTextStyle: TextStyle(color: Colors.grey),
              //                     context: context,
              //                     controller: controller.Name,
              //                     hintText: "Zoe Saldana",
              //                   ),
              //                   Container(
              //                       height: Get.height*0.03,
              //                       width: Get.width*0.06,
              //                       child: Image(image: AssetImage("assets/images/delete.png"))),
              //                 ],
              //               )
              //                   : GestureDetector(
              //                 onTap: (() {
              //                   controller.weekPrice.removeAt(index - 1);
              //                   controller.update();
              //                 }),
              //                 child: Image.asset(
              //                   'assets/images/delete.png',
              //                   width: 13,
              //                   height: 16,
              //                 ),
              //               )),
              //
              //         ],
              //       );
              //     },
              //   );
              // }),
              // h(30),
            ],
          ),
        ),
      ),
        bottomNavigationBar: btmbar(fromOther: true,),
      extendBody: true,
    );
  }
}
