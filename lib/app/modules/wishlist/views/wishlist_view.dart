import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/drawer.dart';

import '../../../../Reusability/utils/util.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<WishlistController>(WishlistController());

  WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Wishlist",
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
      drawer: const CsDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white,
                height: Get.height * 0.85,
                width: Get.width,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        color: Colors.white,
                        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        height: Get.height * 0.25,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: Get.height * 0.12,
                                  width: Get.width * 0.4,
                                  decoration: const BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: SizedBox(
                                          height: Get.height * 0.02,
                                          child: const Image(
                                              image: AssetImage(
                                                  "assets/images/dil.png")),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Children’s Museum"),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              height: Get.height * 0.02,
                                              child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/star.png"))),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          const Text(
                                            "4.0",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          const Text(
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
                                          SizedBox(
                                              height: Get.height * 0.02,
                                              child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/log.png"))),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          SizedBox(
                                              width: Get.width * 0.35,
                                              child: const Text(
                                                "100 Laurier Street, Gatineau..",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                          SizedBox(
                                              height: Get.height * 0.02,
                                              child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/walking.png"))),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          const Text(
                                            "2 min",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          const Text(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Image(
                                      image: AssetImage("assets/images/go.png"),
                                      width: 25,
                                    ),
                                    Text("  Go"),
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width * 0.025,
                                ),
                                const Row(
                                  children: [
                                    Image(
                                      image:
                                          AssetImage("assets/images/plan.png"),
                                      width: 25,
                                    ),
                                    Text("  My Plan"),
                                  ],
                                ),
                                ButtonWithStyle(
                                  onPressed: () {
                                    //   Get.toNamed(Routes.FULL_DETAILS);
                                    //   Get.toNamed(
                                    //     Routes.FULL_DETAILS,
                                    //     arguments: [
                                    //       controller.a?
                                    //           .data![index].id
                                    //     ],
                                    //   );
                                  },
                                  textVal: "Details",
                                  btnwidth: Get.width * 0.3,
                                ),
                              ],
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
      extendBody: true,
    );
  }
}
