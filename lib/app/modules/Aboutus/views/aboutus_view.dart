import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';

import '../controllers/aboutus_controller.dart';

// ignore: must_be_immutable
class AboutusView extends GetView<AboutusController> {
  @override
  var controller = Get.put(AboutusController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  AboutusView({super.key});
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
                        Text(
                          "About us",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Container(
                height: Get.height,
                margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.15,
                        width: Get.width * 0.4,
                        child: Image.asset("assets/images/notslogo.png"),
                      ),
                      Html(
                        data: controller.a?.data?.abouteas ?? "",
                        shrinkWrap: true,
                        // style: {
                        //   "": Style(),
                        // },
                        // onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                        //   //open URL in webview, or launch URL in browser, or any other logic here
                        // }
                      ),
                      // Text(
                      //   controller.a?.data?.abouteas ?? "",
                      //   style: const TextStyle(fontSize: 14),
                      // ),
                      // h(40),
                      // Html(
                      //   data: controller.a?.data?.privacypolicy ?? "",
                      //   shrinkWrap: true,
                      //   // style: {
                      //   //   "": Style(),
                      //   // },
                      //   // onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
                      //   //   //open URL in webview, or launch URL in browser, or any other logic here
                      //   // }
                      // ),
                      h(90),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const btmbar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
