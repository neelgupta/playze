import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/writeareview_controller.dart';

class WriteareviewView extends GetView<WriteareviewController> {
  const WriteareviewView({Key? key}) : super(key: key);
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
                        padding: EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(2),
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
                        Text(LocaleKeys.text_Write_Review.tr,
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
        margin: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.text_Give_your_rating.tr,style: TextStyle(fontSize: 18),),
              h(10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                height: Get.height*0.15,
                width: Get.width,
                child: Center(
                  child: RatingBar.builder(
                    itemSize: 40,
                    initialRating: 3.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ),
              h(10),
              Text(LocaleKeys.text_Write_Review.tr,style: TextStyle(fontSize: 18),),
              h(10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                height: Get.height*0.2,
                width: Get.width,
                child: TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.text_Add_here.tr,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                  controller: controller.Notes,

                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.text_Upload_Videos.tr,style: TextStyle(fontSize: 18),),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: Get.height*0.09,
                    width: Get.width*0.1,
                    decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.amber,),
                    child: Image.asset("assets/images/add.png"),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.selectFile();
                    },
                    child:
                      GetBuilder<WriteareviewController>(
                          builder: (controller) {
                            return Stack(
                              children: [
                                Container(

                                  child: controller.isPicked.value ? Image.file(controller.imageFile!,
                                    width: Get.width*0.4,
                                    height: Get.height*0.11,
                                  )
                                      : Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/images/femily.png"),fit: BoxFit.fill),
                                        color: Colors.blueGrey[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),

                                    width: Get.width*0.4,
                                    height: Get.height*0.11,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: (){
                                      controller.Close();
                                      controller.update();

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      height: Get.height*0.04,
                                      width: Get.width*0.05,
                                      child: Image.asset("assets/images/close.png",),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                      )
                  ),
                  w(10),
                  GestureDetector(
                    onTap: (){
                      controller.selectvieoFile();
                    },
                    child: Obx(()=>
                       Stack(
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(10))
                             ),
                             child: controller.isPickeds.value ? Image.file(controller.imagevideoFile!,
                               width: Get.width*0.4,
                               height: Get.height*0.11,
                             )
                                 : Container(
                               decoration: BoxDecoration(
                                 image: DecorationImage(image: AssetImage("assets/images/femily.png"),fit: BoxFit.fill,),
                                   color: Colors.blueGrey[100],
                                   borderRadius: BorderRadius.all(Radius.circular(10))
                               ),

                               width: Get.width*0.4,
                               height: Get.height*0.11,
                             ),
                           ),
                           Positioned(
                             top: 0,
                             right: 4,
                             child: GestureDetector(
                               onTap: (){

                               },
                               child: Container(
                                 height: Get.height*0.04,
                                 width: Get.width*0.05,
                                 child: Image.asset("assets/images/close.png"),
                               ),
                             ),
                           )
                         ],
                       ),
                    ),
                  ),
                ],
              ),
              h(15),
              ButtonWithStyle(
                onPressed: () {
                  // Get.toNamed(Routes.CHILDINFO);
                },
                textVal: LocaleKeys.buttons_next.tr.toUpperCase(),
                btnwidth: Get.width,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: btmbar(fromOther: true,),
      extendBody: true,
    );
  }
}
