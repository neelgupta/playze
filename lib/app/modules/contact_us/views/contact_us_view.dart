import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/generated/locales.g.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';
import 'package:playze/reusability/shared/custom_drawer.dart';
import 'package:playze/reusability/utils/util.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  ContactUsView({super.key});
  @override
  final controller = Get.put<ContactUsController>(ContactUsController());

  @override
  Widget build(BuildContext context) {
    var bodrer = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    );
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
                    const SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("Contact Us",
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
      drawer: const CustomStartDrawer(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SizedBox(
                height: Get.height * 0.74,
                width: Get.width,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                  child: Form(
                    key: controller.contactFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter Full Name";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.fName,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            isDense: true,
                            border: bodrer,
                            enabledBorder: bodrer,
                            focusedBorder: bodrer,
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Full Name",
                          ),
                        ),
                        h(15),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            var emailRegex = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter Email";
                            } else if (!emailRegex.hasMatch(value)) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          controller: controller.email,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            isDense: true,
                            border: bodrer,
                            enabledBorder: bodrer,
                            focusedBorder: bodrer,
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Email",
                          ),
                        ),
                        h(15),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty || value == " ") {
                              return "Please Enter Massage";
                            }
                            return null;
                          },
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          onChanged: (value) {},
                          controller: controller.massage,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            isDense: true,
                            border: bodrer,
                            enabledBorder: bodrer,
                            focusedBorder: bodrer,
                            hintStyle: const TextStyle(color: Colors.grey),
                            hintText: "Massage",
                          ),
                        ),
                        h(220),
                        ButtonWithStyle(
                          onPressed: () {
                            if (controller.contactFormKey.currentState!
                                .validate()) {
                              controller.userContactus();
                            }
                          },
                          textVal: LocaleKeys.buttons_submit.tr.toUpperCase(),
                          btnwidth: Get.width,
                        ),
                        h(80),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const CustomBottomBar(
        fromOther: true,
      ),
      extendBody: true,
    );
  }
}
