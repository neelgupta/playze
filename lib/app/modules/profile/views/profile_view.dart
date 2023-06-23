import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_drawer.dart';
import 'package:playze/app/routes/app_pages.dart';
import 'package:playze/generated/locales.g.dart';
import 'package:playze/reusability/utils/util.dart';

import '../../../../reusability/utils/app_colors.dart';
import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ProfileView extends GetView<ProfileController> {
  @override
  var controller = Get.put(ProfileController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  ProfileView({super.key});
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
                      width: 20
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("My Profile",
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
                height: Get.height * 0.75,
                // margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                child: RefreshIndicator(
                  onRefresh: () {
                    return controller.getUserProfileData();
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // image: controller.a?.data.images != ''
                                //     ? DecorationImage(
                                //         image: NetworkImage(
                                //             "${controller.a?.data.images}"),
                                //         fit: BoxFit.fill)
                                //     : const DecorationImage(
                                //         image: NetworkImage(""),
                                //         fit: BoxFit.fill),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(200)),
                                child: controller.userDataModal?.data.images !=
                                        ''
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "${controller.userDataModal?.data.images}",
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: AppColors.greyColor
                                                .withOpacity(0.25),
                                            child: const Center(
                                              child: Text(
                                                "No Image",
                                                style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: "",
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: AppColors.greyColor
                                                .withOpacity(0.25),
                                            child: const Center(
                                              child: Text(
                                                "No Image",
                                                style: TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                              // child: controller.a?.data.image!=""?Image(image: NetworkImage("${controller.a?.data.image}"),fit: BoxFit.fill,):
                              //         Image(image: AssetImage("assets/images/NoPath.png"),fit: BoxFit.fill),
                            ),
                            w(15),
                            SizedBox(
                              width: Get.width * 0.4,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "${controller.userDataModal?.data.name}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              LocaleKeys.labels_Edit.tr,
                              style: const TextStyle(fontSize: 14),
                            ),
                            w(10),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROFILE);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                height: Get.height * 0.07,
                                width: Get.width * 0.08,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/nounedit.png",
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        h(5),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (LocaleKeys.labels_name.tr),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                h(5),
                                Text(
                                  "${controller.userDataModal?.data.name}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            )),
                        h(5),
                        const Divider(),
                        h(5),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (LocaleKeys.labels_email.tr),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                h(5),
                                Text(
                                  '${controller.userDataModal?.data.email}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            )),
                        h(5),
                        const Divider(),
                        h(5),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (LocaleKeys.labels_phone.tr),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                h(5),
                                Text(
                                  '${controller.userDataModal?.data.mobileNumber}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            )),
                        h(5),
                        const Divider(),
                        h(5),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (LocaleKeys.labels_Your_Location.tr),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                h(5),
                                Text(
                                  (controller.userDataModal?.data.location ??
                                      ""),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            )),
                        h(25),
                        Text(
                          (LocaleKeys.labels_Children_information.tr),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        h(15),
                        GetBuilder<ProfileController>(
                          builder: (_) {
                            return ListView.separated(
                              separatorBuilder: (context, index) => h(10),
                              itemCount: controller.childrenList.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: index == 0
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr}"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          h(5),
                                                          Text(
                                                            (controller
                                                                .childrenList[
                                                                    index]
                                                                .name),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      )),
                                                  h(5),
                                                  const Divider(),
                                                  h(5),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_age.tr}"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          h(5),
                                                          Text(
                                                            ("${controller.childrenList[index].age} Years"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      )),
                                                  h(5),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_name.tr}"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          h(5),
                                                          Text(
                                                            (controller
                                                                .childrenList[
                                                                    index]
                                                                .name),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      )),
                                                  h(5),
                                                  const Divider(),
                                                  h(5),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            ("${LocaleKeys.labels_childs.tr} ${LocaleKeys.labels_age.tr}"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          h(5),
                                                          Text(
                                                            ("${controller.childrenList[index].age} Years"),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ],
                                                      )),
                                                  h(5),
                                                ],
                                              )),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        h(10),
                        // Text(("Interest"),style: TextStyle(fontSize: 20,color: Colors.black),),

                        // Container(
                        //     margin: EdgeInsets.only(left: 10),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text((LocaleKeys.labels_children.tr + " " +LocaleKeys.labels_name.tr),style: TextStyle(fontSize: 16),),
                        //         h(5),
                        //         Text(("Zoe Saldana"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                        //       ],
                        //     )
                        // ),
                        // h(5),
                        // Divider(),
                        // h(5),
                        // Container (
                        //     margin: EdgeInsets.only(left: 10),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text((LocaleKeys.labels_children.tr + " " + LocaleKeys.labels_age.tr),style: TextStyle(fontSize: 16),),
                        //         h(5),
                        //         Text(("6 Years"),style: TextStyle(fontSize: 18,color: Colors.grey),),
                        //       ],
                        //     )
                        // ),
                        // h(5),
                        // Divider(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      extendBody: true,
    );
  }
}
