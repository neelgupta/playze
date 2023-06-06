import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../controllers/addplaces_controller.dart';

class AddplacesView extends GetView<AddplacesController> {
  const AddplacesView({Key? key}) : super(key: key);
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
                padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(2),
                              child: Image(
                                image: AssetImage("assets/images/back.png"),
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
                        Text("Add Pleces",
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
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Container(
              height: Get.height,
              width: Get.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.SEARCH);
                            },
                            child: Container(
                              height: Get.height * 0.06,
                              width: Get.width * 0.75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Container(
                                      height: Get.height * 0.05,
                                      width: Get.width * 0.07,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/search.png"))),
                                  SizedBox(
                                    width: Get.width * 0.03,
                                  ),
                                  Container(
                                    height: Get.height * 0.3,
                                    width: Get.width * 0.5,
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: "Search places",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.FILTER);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: Get.height * 0.06,
                              width: Get.width * 0.13,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Image.asset("assets/images/menu2.png"),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        color: Colors.white,
                        height: Get.height * 0.7,
                        width: Get.width,
                        child: ListView.builder(
                          itemCount: controller.images.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                height: Get.height * 0.25,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 10,
                                                left: 10,
                                                child: Container(
                                                  child: Image(
                                                      image: AssetImage(
                                                          "assets/images/dil.png")),
                                                  height: Get.height * 0.02,
                                                ),
                                              )
                                            ],
                                          ),
                                          height: Get.height * 0.12,
                                          width: Get.width * 0.4,
                                          decoration: BoxDecoration(
                                              color: Colors.cyan,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .Data[index]
                                                      .images![index]
                                                      .images
                                                      .toString()))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${controller.Data[index].placesName}"),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: Get.height * 0.02,
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/images/star.png"))),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    "${controller.Data[index].rating}",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    "150 Reviews",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: Get.height * 0.02,
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/images/log.png"))),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Container(
                                                      width: Get.width * 0.35,
                                                      child: Text(
                                                        "${controller.Data[index].address}",
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: Get.height * 0.02,
                                                      child: Image(
                                                          image: AssetImage(
                                                              "assets/images/walking.png"))),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    "2 min",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Text(
                                                    "1 km away",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.025,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/go.png"),
                                              width: 25,
                                            ),
                                            Text("  Go"),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.025,
                                        ),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/plan.png"),
                                              width: 25,
                                            ),
                                            Text("  My Plan"),
                                          ],
                                        ),
                                        ButtonWithStyle(
                                          onPressed: () {
                                            // Get.toNamed(Routes.FULL_DETAILS);
                                          },
                                          textVal: "Details",
                                          btnwidth: Get.width * 0.3,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      bottomNavigationBar: btmbar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
