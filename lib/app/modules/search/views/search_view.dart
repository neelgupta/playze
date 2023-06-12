import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playze/Reusability/utils/app_colors.dart';

import '../../../../Reusability/utils/util.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchScreenController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.searchController.text = controller.filterProv.searchString;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: Get.height * 0.07,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: const Image(
                                image: AssetImage("assets/images/back.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Search",
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
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Container(
                height: Get.height,
                width: Get.width,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.06,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        children: [
                          SizedBox(width: Get.width * 0.03),
                          SizedBox(
                            height: Get.height * 0.05,
                            width: Get.width * 0.07,
                            child: const Image(
                              image: AssetImage("assets/images/search.png"),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.03),
                          SizedBox(
                            height: Get.height * 0.3,
                            width: Get.width * 0.5,
                            child: TextFormField(
                              controller: controller.searchController,
                              decoration: const InputDecoration(
                                hintText: "Search places",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: Get.height * 0.08,
                      child: const Text(
                        "What are you searching for?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    GetBuilder<SearchScreenController>(builder: (context) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: controller.CategoryList.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        separatorBuilder: (context, index) {
                          return h(4);
                        },
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              controller.selectedId.value =
                                  controller.CategoryList[index].id;
                              controller.filterProv.updateFilterDataList(
                                [
                                  controller.CategoryList[index],
                                ],
                              );
                              controller.searchController.clear();
                              controller.filterProv.updateSearchData(
                                  controller.searchController.text);
                              controller.filterPlacesListByCategory();
                            },
                            dense: true,
                            selected: controller.CategoryList[index].isSelected,
                            selectedTileColor: AppColors.primaryColor,
                            title: Text(
                              controller.CategoryList[index].name,
                              style: TextStyle(
                                color: controller.CategoryList[index].isSelected
                                    ? AppColors.whiteColor
                                    : AppColors.greyColor,
                              ),
                            ),
                            // subtitle: Text(
                            //   controller.CategoryList[index].isSelected
                            //       ? "selected"
                            //       : "",
                            //   style: const TextStyle(color: Colors.grey),
                            // ),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: controller.CategoryList[index].isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.greyColor,
                              size: 16,
                            ),
                          );

                          // SizedBox(
                          //   height: Get.height * 0.06,
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         controller.CategoryList[index].name,
                          //         style: const TextStyle(color: Colors.grey),
                          //       ),
                          //       const Spacer(),
                          //       const Icon(
                          //         Icons.arrow_forward_ios,
                          //         color: Colors.grey,
                          //         size: 16,
                          //       )
                          //     ],
                          //   ),
                          // );
                        },
                      );
                    }),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.clearAllFilterAndSearch();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffFE7702),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              height: Get.height * 0.06,
                              width: Get.width * 0.4,
                              child: Text(
                                "Clear All".toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xffFE7702),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.filterPlacesListBySearchData();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color(0xffFE7702),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              height: Get.height * 0.06,
                              width: Get.width * 0.4,
                              child: Text(
                                "Search".toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
