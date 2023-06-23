import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playze/Reusability/shared/custom_drawer.dart';
import 'package:playze/reusability/shared/custom_bottom_bar.dart';

import '../controllers/playze_workspace_controller.dart';
import '../widgets/playze_workspace_widgets.dart';

// ignore: must_be_immutable
class PlayzeWorkspaceView extends StatelessWidget {
  PlayzeWorkspaceView({Key? key}) : super(key: key);

  var controller = Get.put(PlayzeWorkSpaceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
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
                        controller.scaffoldKey.currentState!.openDrawer();
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
                        Text(
                          "Playze Workspace",
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
      drawer: const CustomStartDrawer(),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        controller.workSpaceListModel != null
                            ? Container(
                                color: Colors.white,
                                height: Get.height * 0.75,
                                width: Get.width,
                                child: controller
                                        .workSpaceListModel!.data.isEmpty
                                    ? const Center(
                                        child: Text("No WorkSpace Available"),
                                      )
                                    : RefreshIndicator(
                                        onRefresh: () {
                                          return controller.getWorkSpaceList();
                                        },
                                        child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 12),
                                          itemCount: controller
                                              .workSpaceListModel!.data.length,
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(height: 10);
                                          },
                                          itemBuilder: (context, index) {
                                            var item = controller
                                                .workSpaceListModel!
                                                .data[index];
                                            return SingleWorkSpaceWidget(
                                              workSpaceData: item,
                                            );
                                          },
                                        ),
                                      ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
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
