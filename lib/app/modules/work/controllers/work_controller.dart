// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:playze/app/data/modal/work_space_model.dart';
// import 'package:playze/app/data/service/user_service.dart';

// class WorkController extends GetxController {
//   //TODO: Implement WorkController

//   RxBool isLoading = false.obs;
//   UserService userService = UserService();
//   WorkSpaceListModel? workSpaceListModel;

//   Future<void> getwork() async {
//     isLoading(true);
//     try {
//       workSpaceListModel = await userService.getWorkSpacesListMethod();
//       if (workSpaceListModel?.status == 200) {
//         Fluttertoast.showToast(
//             msg: '${a?.message}',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.blue,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       } else {
//         Fluttertoast.showToast(
//             msg: '${a?.message}',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.blue,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//       update();
//     } catch (e) {
//       log(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
