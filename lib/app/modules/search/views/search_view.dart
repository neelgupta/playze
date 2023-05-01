import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
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
                        Text("Search",
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
              height: Get.height*0.06,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              child: Row(
                children: [
                  SizedBox(width: Get.width*0.03,),
                  Container(
                      height: Get.height*0.05,
                      width: Get.width*0.07,
                      child: Image(image: AssetImage("assets/images/search.png"))),
                  SizedBox(width: Get.width*0.03,),
                  Container(
                    height: Get.height*0.3,
                    width: Get.width*0.5,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search places",
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: Get.height*0.08,
              child: Text("What are you searching for?",style: TextStyle(fontSize: 20),),
            ),
            Container(
              height: Get.height*0.6,
              child: ListView.builder(itemCount: 10,itemBuilder: (context, index) {
                return Container(
                  height: Get.height*0.06,
                  child: Row(
                    children: [
                      Text("Science Museum",style: TextStyle(color: Colors.grey),),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 16,)
                    ],
                  ),
                );
              },),
            ),
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
                    child: Text("Clear All".toUpperCase(),style: TextStyle(color: Color(0xffFE7702))),
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
                    child: Text("Search".toUpperCase(),style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
