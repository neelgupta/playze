import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';

import '../controllers/myplan_controller.dart';

class MyplanView extends GetView<MyplanController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final controller = Get.put<MyplanController>(MyplanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _key,
      appBar:  AppBar(
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
                        _key.currentState!.openDrawer();
                        print("100");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image:
                                AssetImage("assets/images/menu.png"),
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
                        Text("My Plan",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                            )),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                      ),
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image(
                              image:
                              AssetImage("assets/images/search.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                      ),
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(0),
                            child: Image(
                              image:
                              AssetImage("assets/images/share.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                      ),
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image(
                              image:
                              AssetImage("assets/images/mapviwe.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: BoxDecoration(
                      ),
                      child: Center(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image(
                              image:
                              AssetImage("assets/images/more3.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: CsDrawer(),
      body: Container(
        margin: EdgeInsets.only(top: 25),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height*0.73,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: ReorderableListView(
                    children: <Widget>[
                      for (int index = 0; index < controller.items.length; index += 1)
                        Container(
                          key: Key('$index'),
                          child: Column(
                            children: [
                              index == 0?Row(
                                children: [
                                  Text("Day"),
                                  w(5),
                                  Container(
                                    alignment: Alignment.center,
                                    height: Get.height*0.05,
                                    width: Get.width*0.06,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),

                                    child: Text("1"),
                                  )
                                ],
                              ):SizedBox(),
                              Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  height: Get.height*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                                      ),
                                                      height: Get.height*0.04,
                                                      width: Get.width*0.15,
                                                      child: Text("10:00",style: TextStyle(fontSize: 12),),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 70,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                                                ),
                                                                height: Get.height*0.9,
                                                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      Text(LocaleKeys.labels_Edit.tr.toUpperCase(),style: TextStyle(fontSize: 20),),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Change_Start_Time.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Remove.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Change_Duration.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Change_Day.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Change_Order.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)
                                                                        ),
                                                                        width: Get.width,
                                                                        height: 45,
                                                                        child: Text(LocaleKeys.buttons_Manage_Days.tr.toUpperCase(),style: AppTextStyle.size14Medium.copyWith(color: Colors.grey.shade300),),
                                                                      ),
                                                                      h(15),
                                                                      ButtonWithStyle(
                                                                        onPressed: () {

                                                                        },
                                                                        textVal: LocaleKeys.buttons_Cancel.tr.toUpperCase(),
                                                                        btnwidth: Get.width,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                        );
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.all(7),
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                                          ),
                                                          height: Get.height*0.04,
                                                          width: Get.width*0.1,
                                                          child: Image.asset("assets/images/edit-line.png")
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              height: Get.height*0.12,
                                              width: Get.width*0.8,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: AssetImage("assets/images/pic.png"),fit: BoxFit.fill),
                                                  color: Colors.cyan,
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height*0.025,),
                                      Container(
                                          margin: EdgeInsets.only(left: 10,right: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Children’s Museum",style: TextStyle(fontSize: 16),),
                                              h(5),
                                              Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut",style: TextStyle(fontSize: 12),),
                                              h(10),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: Get.width*0.3,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.all(7),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                                            ),
                                                            height: Get.height*0.04,
                                                            width: Get.width*0.1,
                                                            child: Image.asset("assets/images/Navigate.png")
                                                        ),
                                                        w(10),
                                                        Text("Navigate",style: TextStyle(fontSize: 14),)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: Get.width*0.3,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.all(7),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                                            ),
                                                            height: Get.height*0.04,
                                                            width: Get.width*0.1,
                                                            child: Image.asset("assets/images/clock.png")
                                                        ),
                                                        w(10),
                                                        Text("Open",style: TextStyle(fontSize: 14),)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              index!=4 ?Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Image.asset("assets/images/Line.png"),
                                      height: Get.height*0.08,
                                      width: Get.width*0.02,
                                    ),
                                    w(10),
                                    Container(
                                      child: Image.asset("assets/images/Blueman.png"),
                                      height: Get.height*0.08,
                                      width: Get.width*0.04,
                                    ),
                                    w(5),
                                    Text("2 min by walking",style: TextStyle(fontSize: 12),)
                                  ],
                                ),
                              ):Container()
                            ],
                          ),
                        )
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final int item = controller.items.removeAt(oldIndex);
                      controller.items.insert(newIndex, item);
                    },
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: (){
                      Get.offNamed(Routes.ADDPLACES);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: Get.height*0.09,
                      width: Get.width*0.15,
                      decoration: BoxDecoration(
                          color: Color(0xffFE7702),
                          shape: BoxShape.circle
                      ),
                      child:  Icon(Icons.add,size: 30,color: Colors.white,),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
