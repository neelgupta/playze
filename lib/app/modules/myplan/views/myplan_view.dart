import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/shared/textStyle.dart';
import 'package:playze/Reusability/utils/util.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1, //
        flexibleSpace: Container(
          height: Get.height * 0.2,
          color: const Color(0xff0264C5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                        print("100");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage("assets/images/menu.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("My Plan",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Image(
                              image: AssetImage("assets/images/search.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.all(0),
                            child: const Image(
                              image: AssetImage("assets/images/share.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Image(
                              image: AssetImage("assets/images/mapviwe.png"),
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: Get.height * 0.06,
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Image(
                              image: AssetImage("assets/images/more3.png"),
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
      drawer: const CsDrawer(),
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height * 0.73,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ReorderableListView(
                    children: <Widget>[
                      for (int index = 0;
                          index < controller.items.length;
                          index += 1)
                        Container(
                          key: Key('$index'),
                          child: Column(
                            children: [
                              index == 0
                                  ? Row(
                                      children: [
                                        const Text("Day"),
                                        w(5),
                                        Container(
                                          alignment: Alignment.center,
                                          height: Get.height * 0.05,
                                          width: Get.width * 0.06,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orange,
                                          ),
                                          child: const Text("1"),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              Card(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  // height: Get.height*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: Get.height * 0.12,
                                              width: Get.width * 0.8,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/pic.png"),
                                                      fit: BoxFit.fill),
                                                  color: Colors.cyan,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 10,
                                                    left: 10,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      height: Get.height * 0.04,
                                                      width: Get.width * 0.15,
                                                      child: const Text(
                                                        "10:00",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 70,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        topRight:
                                                                            Radius.circular(20))),
                                                                height:
                                                                    Get.height *
                                                                        0.9,
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    20,
                                                                    20,
                                                                    20,
                                                                    0),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        LocaleKeys
                                                                            .labels_Edit
                                                                            .tr
                                                                            .toUpperCase(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Change_Start_Time
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Remove
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Change_Duration
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Change_Day
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Change_Order
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                const BorderRadius.all(Radius.circular(5)),
                                                                            border: Border.all(color: Colors.grey.shade300)),
                                                                        width: Get
                                                                            .width,
                                                                        height:
                                                                            45,
                                                                        child:
                                                                            Text(
                                                                          LocaleKeys
                                                                              .buttons_Manage_Days
                                                                              .tr
                                                                              .toUpperCase(),
                                                                          style: AppTextStyle
                                                                              .size14Medium
                                                                              .copyWith(color: Colors.grey.shade300),
                                                                        ),
                                                                      ),
                                                                      h(15),
                                                                      ButtonWithStyle(
                                                                        onPressed:
                                                                            () {},
                                                                        textVal: LocaleKeys
                                                                            .buttons_Cancel
                                                                            .tr
                                                                            .toUpperCase(),
                                                                        btnwidth:
                                                                            Get.width,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(7),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          20))),
                                                          height:
                                                              Get.height * 0.04,
                                                          width:
                                                              Get.width * 0.1,
                                                          child: Image.asset(
                                                              "assets/images/edit-line.png")),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Children’s Museum",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              h(5),
                                              const Text(
                                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              h(10),
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    // width: Get.width * 0.3,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            height: Get.height *
                                                                0.04,
                                                            width:
                                                                Get.width * 0.1,
                                                            child: Image.asset(
                                                                "assets/images/Navigate.png")),
                                                        w(10),
                                                        const Text(
                                                          "Navigate",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    // width: Get.width * 0.3,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                            height: Get.height *
                                                                0.04,
                                                            width:
                                                                Get.width * 0.1,
                                                            child: Image.asset(
                                                                "assets/images/clock.png")),
                                                        w(10),
                                                        const Text(
                                                          "Open",
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              h(10),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              index != 4
                                  ? Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: Get.height * 0.08,
                                            width: Get.width * 0.02,
                                            child: Image.asset(
                                                "assets/images/Line.png"),
                                          ),
                                          w(10),
                                          Container(
                                            height: Get.height * 0.08,
                                            width: Get.width * 0.04,
                                            child: Image.asset(
                                                "assets/images/Blueman.png"),
                                          ),
                                          w(5),
                                          const Text(
                                            "2 min by walking",
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container()
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
                    onTap: () {
                      Get.offNamed(Routes.ADDPLACES);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: Get.height * 0.09,
                      width: Get.width * 0.15,
                      decoration: const BoxDecoration(
                          color: Color(0xffFE7702), shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
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
