import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/drawer.dart';

import '../controllers/myplan_controller.dart';
import '../widgets/myplan_widgets.dart';

class MyplanView extends GetView<MyplanController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  final controller = Get.put<MyplanController>(MyplanController());

  MyplanView({super.key});
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
                    const SizedBox(width: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "My Plan",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const MyPlansListview(),
                      AddPlaceButton(),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
