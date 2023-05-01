import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/commonTextField.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/childinfo_controller.dart';

class ChildinfoView extends GetView<ChildinfoController> {
  const ChildinfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: Get.width*0.4,child: Image.asset("assets/images/appIcon.png")),
              h(20),
              Text(LocaleKeys.text_create_account.tr,style: AppTextStyle.size18Medium.copyWith(letterSpacing: 1.8,fontSize: 20,fontWeight: FontWeight.w600)),
              h(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.labels_Children_information.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 16)),
                  Container(
                    alignment: Alignment.center,
                    height: Get.height*0.04,
                    width: Get.width*0.08,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add,color: Colors.white,),
                  ),
                ],
              ),
              h(20),
              Text(LocaleKeys.text_Create_Account_nots.tr,style: AppTextStyle.size18Medium.copyWith(fontSize: 12)),
              h(20),
              InputTextField(
                context: context,
                controller: controller.nameController,
                hintText: LocaleKeys.labels_children.tr + " " + LocaleKeys.labels_name.tr,
              ),
              h(15),
              InputTextField(
                context: context,
                controller: controller.ageController,
                hintText: LocaleKeys.labels_children.tr + " " + LocaleKeys.labels_age.tr,
              ),
              h(20),
              Text("Interest ",style: AppTextStyle.size18Medium.copyWith(fontSize: 16)),
              Container(
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                    Container(
                      height: Get.height*0.3,
                      child: GridView.builder(itemCount: controller.arrSongList.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 4), itemBuilder: (context, index) {
                        return
                           Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: ElevatedButton(
                                style: ButtonStyle(),
                                child: Text(controller.arrSongList[index],style: TextStyle(color: Colors.white),),
                                onPressed: () => {

                                }
                            ),
                          );
                      },),
                    )
                  ],
                ),
              ),
              h(15),
          ButtonWithStyle(
                onPressed: () {
                  Get.toNamed(Routes.VERIFICATION);
                },
                textVal: LocaleKeys.buttons_sign_up.tr.toUpperCase(),
                btnwidth: Get.width,
              ),
              h(10),
              Center(
                child: RichText(text: TextSpan(
                    children: [
                      TextSpan(text: LocaleKeys.text_already_have_account.tr,style: AppTextStyle.size12Medium),
                      TextSpan(
                          text: " ${LocaleKeys.buttons_log_in.tr}",
                          style: AppTextStyle.size12Medium.copyWith(color: Colors.orange,decoration: TextDecoration.underline,height: 1.5),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Get.back();
                          }
                      ),
                    ]
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
