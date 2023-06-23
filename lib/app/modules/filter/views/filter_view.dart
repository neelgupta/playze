import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:playze/app/data/modal/filters_model.dart';
import 'package:playze/reusability/utils/app_colors.dart';

import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    // int number = controller.filterList.length;
    // int count = number;
    // List<bool> _checks = List.generate(count, (_) => false).obs;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1,
        backgroundColor: AppColors.primaryColor,
        flexibleSpace: Column(
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
                      padding: const EdgeInsets.all(8),
                      height: Get.height * 0.07,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: const Image(
                            image: AssetImage("assets/images/back.png"),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Filter",
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: controller.filterList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GetBuilder<FilterController>(
                          builder: (controlles) {
                            // int number = controller.filterList.length;
                            // int count = number;
                            var singleItem = controller.filterList[index];
                            // List<bool> checks =
                            //     List.generate(count, (_) => false).obs;
                            return CheckboxListTile(
                              value: singleItem.isSelected,
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: const EdgeInsets.only(
                                left: 5,
                                bottom: 0,
                                right: 0,
                                top: 0,
                              ),
                              activeColor: AppColors.primaryColor,
                              side: const BorderSide(color: Colors.black26),
                              onChanged: (newValue) {
                                singleItem.isSelected = newValue!;
                                controller.update();

                                controller.selectedCount.value = 0;
                                for (var item in controller.filterList) {
                                  if (item.isSelected) {
                                    controller.selectedCount.value += 1;
                                  }
                                }
                                // print(controlles.isbool[index]);
                              },
                              dense: true,
                              checkboxShape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                side: BorderSide(color: Colors.black26),
                              ),
                              checkColor: AppColors.whiteColor,
                              title: Text(
                                singleItem.name,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    // const Spacer(),

                    // const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // for (var item in controller.filterList) {
                  //   item.isSelected = false;
                  // }
                  // controller.update();
                  controller.clearFilterHomeScreenPlacesList();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffFE7702)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  height: Get.height * 0.06,
                  // width: Get.width * 0.4,
                  width: double.infinity,
                  child: Text(
                    "Reset".toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xffFE7702),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  //filter api call
                  controller.selectedCatIdList = [];

                  List<FilterData> selectedList = [];
                  for (var item in controller.filterList) {
                    if (item.isSelected) {
                      log("item.isSelected ::  ${item.id}");
                      controller.selectedCatIdList.add(item.id.toString());
                      selectedList.add(item);
                    }
                  }

                  if (controller.selectedCatIdList.isEmpty) {
                    controller.filterProv.updateFilterDataList(selectedList);
                    Fluttertoast.showToast(
                      msg: 'Please select any category to filter out places.',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    controller.filterProv.updateFilterDataList(selectedList);
                    controller.categoryFilterSearchApi();
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xffFE7702),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    height: Get.height * 0.06,
                    // width: Get.width * 0.4,
                    width: double.infinity,
                    child: Text(
                      "Apply (${controller.selectedCount.value})".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
