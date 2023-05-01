import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';

import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  final controller = Get.put<FilterController>(FilterController());
  @override
  Widget build(BuildContext context) {
    int number = 15;
    int count = number;
    List<bool> _checks = List.generate(count , (_) => false).obs;
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
                        height: Get.height * 0.07,
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
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Filter",
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
        width: Get.width,
        margin: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          children: [
            Container(
              height: Get.height*0.75,
              child: ListView.builder(itemCount: number,itemBuilder: (context, index) {
                return Container(
                  height: Get.height*0.06,
                  child: Row(
                    children: [
                      Obx(()=>
                          Checkbox(
                              activeColor: Colors.deepOrange,
                              value: _checks[index],
                              side: BorderSide(color: Colors.black12),
                              onChanged: (newValue) {
                                _checks[index] = newValue!;
                                print( _checks[index]);
                              }
                          ),
                      ),
                      Text("Science Museum",style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                );
              },),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(

                        border: Border.all(color: Color(0xffFE7702)),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    height: Get.height*0.06,
                    width: Get.width*0.4,
                    child: Text("Reset".toUpperCase(),style: TextStyle(color: Color(0xffFE7702))),
                  ),
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffFE7702),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    height: Get.height*0.06,
                    width: Get.width*0.4,
                    child: Text("Apply".toUpperCase(),style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
