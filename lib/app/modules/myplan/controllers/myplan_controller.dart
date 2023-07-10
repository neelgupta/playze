import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playze/app/data/service/plan_service.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../../reusability/utils/util.dart';
import '../../../data/modal/place_data_model.dart';
import '../../../data/modal/plan_days_get_list.dart';
import '../../../data/modal/plan_get_list.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controller.dart';
import '../../home/controllers/home_controller.dart';

class MyplanController extends GetxController {
  final count = 0.obs;
  final List<int> items = List<int>.generate(5, (int index) => index);

  RxInt countMins = 0.obs;
  RxString timeInMins = "".obs;
  RxInt selectedDay = 1.obs;

  PlanService planService = PlanService();
  RxBool isLoading = false.obs;
  RxBool isPlansLoading = false.obs;

  List startTimeList = [];
  List<TimeOfDay> changeDurationList = [];
  List<String> changeDayList = [];
  List<String> reorderPlacesList = [];
  List<String> reorderPlacesKeyList = [];
  List<String> manageDaysList = [];
  TabController? dayTabBarController;

  RxBool locWhenInUseGranted = false.obs;
  RxBool locAlwaysGranted = false.obs;

  LatLng? location;
  // = const LatLng(23.812433, 79.305474);
  late Position currentLocation;
  LocationPermission permission = LocationPermission.denied;

  //api model & lists
  DayDatum? selectedDayData;
  List<DayDatum> daysList = [];
  List<PlanData> planDataList = [];

  makeStartTimeList() {
    var startTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      7,
      0,
    );

    var nextDay = DateTime.now().add(const Duration(days: 1));

    var endTime = DateTime(
      nextDay.year,
      nextDay.month,
      nextDay.day,
      6,
      30,
    );
    startTimeList.clear();
    var interval = const Duration(minutes: 15);
    // var timeList = [];
    while (startTime.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
      startTime = startTime.add(interval);
      startTimeList.add(startTime);
    }
    // log("startTimeList : $startTimeList");
  }

  makeChangeDurationList() {
    changeDurationList = [];
    countMins.value = 0;
    TimeOfDay calHoursTime = minutesToTimeOfDay(countMins.value);
    changeDurationList.add(calHoursTime);
    int interval = 15;
    for (int i = 0; i < 24; i++) {
      countMins.value += interval;

      TimeOfDay calHoursTime = minutesToTimeOfDay(countMins.value);
      // log("calHoursTime \nhour : ${calHoursTime.hour} minute : ${calHoursTime.minute}");
      changeDurationList.add(calHoursTime);
    }
    // log("changeDurationList length ;: ${changeDurationList.length}");
  }

  makeChangeDayList() {
    changeDayList = [];
    selectedDay.value = 1;
    int countDay = 1;
    // TimeOfDay calHoursTime = minutesToTimeOfDay(countMins.value);
    // changeDayList.add(countDay.toString());
    // int interval = 15;
    changeDayList.add(countDay.toString());
    for (int i = 0; i < 5; i++) {
      countDay++;
      changeDayList.add(countDay.toString());
    }
    // log("changeDayList length ;: $changeDayList");
  }

  // reorderDayList() {
  //   reorderPlacesList = [];
  //   reorderPlacesKeyList = [];

  //   reorderPlacesList.add("9:00AM The Place");
  //   reorderPlacesKeyList.add("The Place");
  //   reorderPlacesList.add("11:22AM The Second polkace");
  //   reorderPlacesKeyList.add("The Second polkace");
  //   reorderPlacesList.add("2:00PM The Sida");
  //   reorderPlacesKeyList.add("The Sida");
  //   reorderPlacesList.add("3:45PM Uglasia");
  //   reorderPlacesKeyList.add("Uglasia");

  //   // for (int i = 0; i < 3; i++) {
  //   //   countDay++;
  //   //   changeDayList.add(countDay.toString());
  //   // }
  //   // log("reorderPlacesList length ;: $reorderPlacesList");
  //   // log("reorderPlacesKeyList length ;: $reorderPlacesKeyList");
  // }

  makeManageDaysList() {
    manageDaysList = [];
    // reorderPlacesKeyList = [];

    manageDaysList.add("Day 1 (The Place)");
    manageDaysList.add("Day 2 (The Second polkace)");
    manageDaysList.add("Day 3 (empty)");
    manageDaysList.add("Day 4 Uglasia");
    manageDaysList.add("Day 5 (empty)");

    // reorderPlacesKeyList.add("The Place");
    // reorderPlacesKeyList.add("The Second polkace");
    // reorderPlacesKeyList.add("The Sida");
    // reorderPlacesKeyList.add("Uglasia");

    // for (int i = 0; i < 3; i++) {
    //   countDay++;
    //   changeDayList.add(countDay.toString());
    // }
    // log("manageDaysList length ;: $manageDaysList");
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  planDaysGetListFunction() async {
    try {
      isLoading(true);

      currentLocation = await locateUser();
      PlanDaysGetList? planDaysGetList =
          await planService.planDaysGetListMethod();

      daysList.clear();
      if (planDaysGetList != null) {
        daysList = planDaysGetList.data;
        if (daysList.isNotEmpty) {
          selectedDayData = daysList.first;
          log("selectedDayData  is : ${selectedDayData!.day}");
        }
        log("daysList len is : ${daysList.length}");
        update();
      } else {
        Fluttertoast.showToast(
          msg:
              'Something went wrong getting plans list. Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      update();
    } catch (e) {
      log(" error is :: ${e.toString()}");
      rethrow;
    } finally {
      // isLoading(false);
      planGetlistByDayFunction();
    }
  }

  planGetlistByDayFunction() async {
    try {
      isPlansLoading(true);

      permission = await Geolocator.requestPermission();
      currentLocation = await locateUser();

      planDataList.clear();
      PlanGetList? planGetList = await planService.planGetlistByDayMethod(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        day: selectedDayData!.dayNumber,
      );

      if (planGetList != null) {
        planDataList = planGetList.data;
        // selectedDayData = daysList.first;
        // log("selectedDayData!.dayNumber : ${selectedDayData!.dayNumber}");

        if (planDataList.isNotEmpty) {
          for (var item in planDataList) {
            reorderPlacesKeyList.add(item.id);
          }
        }
        log("planDataList len is : ${planDataList.length}");
        update();
        isPlansLoading(false);
      } else {
        Fluttertoast.showToast(
          msg: 'Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      update();
    } catch (e) {
      isPlansLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {
      locAlwaysGranted.value =
          await Permission.locationAlways.request().isGranted;

      locWhenInUseGranted.value =
          await Permission.locationWhenInUse.request().isGranted;
      log('permission.value ::  $permission');
      log('locAlwaysGranted.value ::  ${locAlwaysGranted.value}');
      log('locWhenInUseGranted.value ::  ${locWhenInUseGranted.value}');
      isLoading(false);
      isPlansLoading(false);
    }
  }

  addDayToList() async {
    try {
      isLoading(true);

      bool dayAdded = await planService.addDayToListMethod() ?? false;

      if (dayAdded) {
        Fluttertoast.showToast(
            msg: 'Day Added Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planDaysGetListFunction();
      } else {
        Fluttertoast.showToast(
            msg: 'Day Not Added Something Went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {
      // isLoading(false);
    }
  }

  deleteDayFromList({dayNumber}) async {
    try {
      isLoading(true);

      bool dayAdded =
          await planService.deleteDayFromListMethod(dayNumber: dayNumber) ??
              false;

      if (dayAdded) {
        Fluttertoast.showToast(
            msg: 'Day Deleted Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planDaysGetListFunction();
      } else {
        Fluttertoast.showToast(
            msg: 'Day Not Deleted Something Went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  deletePlanFromList({planId}) async {
    try {
      isLoading(true);

      bool dayAdded =
          await planService.planDeleteFromListMethod(planId: planId) ?? false;

      if (dayAdded) {
        Fluttertoast.showToast(
            msg: 'Plan Deleted Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planDaysGetListFunction();
      } else {
        Fluttertoast.showToast(
            msg: 'Plan Not Deleted Something Went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  dayPlanChangeFunction({planId, dayNumber}) async {
    try {
      isLoading(true);

      bool dayPlanChanged = await planService.planDayChangeApiMethod(
              planId: planId, dayNumber: dayNumber) ??
          false;

      if (dayPlanChanged) {
        Get.back();
        Fluttertoast.showToast(
            msg: 'Plan Moved to day $dayNumber',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planGetlistByDayFunction();
      } else {
        Fluttertoast.showToast(
            msg: 'Moving Plan to day $dayNumber failed. Something Went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  Future<bool> planReorderInListFunction({oldIndex, newIndex}) async {
    try {
      isLoading(true);

      var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      bool dayPlanChanged = await planService.planReorderInDayApiMethod(
            userId: userId,
            oldIndexNumber: oldIndex,
            newIndexNumber: newIndex,
          ) ??
          false;

      if (dayPlanChanged) {
        // Get.back();
        Fluttertoast.showToast(
            msg: 'Plan Reordered Successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planGetlistByDayFunction();
        return true;
      } else {
        Fluttertoast.showToast(
            msg: 'Plan Reordering failed. Something Went wrong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  Future<bool> changeStartTimeOfPlanInDayApiMethod(
      {planId, startTime, dayNumber}) async {
    try {
      isLoading(true);

      bool startTimeChanged =
          await planService.changeStartTimeOfPlanInDayApiMethod(
                planId: planId,
                startTime: startTime,
                dayNumber: dayNumber,
              ) ??
              false;

      if (startTimeChanged) {
        Get.back();
        Fluttertoast.showToast(
            msg: 'Start Time Changed Successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planGetlistByDayFunction();
        return true;
      } else {
        Fluttertoast.showToast(
            msg:
                'Start Time Changing failed. Something Went wrong. Please try again later...!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  Future<bool> changeTimeDurationOfPlanInDayApiMethod(
      {planId, dayNumber, durationTime}) async {
    try {
      isLoading(true);

      // var userId = SharedPrefs().value.read(SharedPrefs.userIdKey);

      bool durationTimeChanged =
          await planService.changeTimeDurationOfPlanInDayApiMethod(
                planId: planId,
                dayNumber: dayNumber,
                durationTime: durationTime,
              ) ??
              false;

      if (durationTimeChanged) {
        Get.back();
        Fluttertoast.showToast(
            msg: 'Time Duration Changed Successfully.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        planGetlistByDayFunction();
        return true;
      } else {
        Fluttertoast.showToast(
            msg:
                'Time Duration Changing failed. Something Went wrong. Please try again later...!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {}
  }

  gotoMapPlaceLocation({placeId}) {
    if (Get.isRegistered<HomeController>() &&
        Get.isRegistered<BottomNavigationBarController>()) {
      var homeController = Get.find<HomeController>();
      var bottomBarController = Get.find<BottomNavigationBarController>();
      homeController.isMapView.value = true;
      PlaceDetails? singlePlace;
      for (var item in homeController.placeDataList) {
        if (item.id == placeId) {
          singlePlace = item;
        }
      }
      if (singlePlace != null) {
        homeController.selectedPlaceLocation = singlePlace;
      }
      homeController.initialCameraPosition = CameraPosition(
        target: LatLng(
          double.parse(homeController.selectedPlaceLocation!.latitude),
          double.parse(homeController.selectedPlaceLocation!.longitude),
        ),
        tilt: 10,
        zoom: 14.5,
      );

      bottomBarController.selectedIndex.value = 0;
      bottomBarController.locateWindowPop.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();

    planDaysGetListFunction();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void increment() => count.value++;
}
