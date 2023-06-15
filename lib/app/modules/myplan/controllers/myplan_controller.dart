import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playze/app/data/service/plan_service.dart';

import '../../../../Reusability/utils/util.dart';
import '../../../data/modal/plan_days_get_list.dart';
import '../../../data/modal/plan_get_list.dart';

class MyplanController extends GetxController {
  final count = 0.obs;
  final List<int> items = List<int>.generate(5, (int index) => index);

  RxInt countMins = 0.obs;
  RxString timeInMins = "".obs;
  RxInt selectedDay = 1.obs;

  PlanService planService = PlanService();
  RxBool isLoading = false.obs;

  List startTimeList = [];
  List<TimeOfDay> changeDurationList = [];
  List<String> changeDayList = [];
  List<String> reorderPlacesList = [];
  List<String> reorderPlacesKeyList = [];
  List<String> manageDaysList = [];
  TabController? dayTabBarController;

  LatLng? location;
  late Position currentLocation;
  LocationPermission? permission;

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
      log("calHoursTime \nhour : ${calHoursTime.hour} minute : ${calHoursTime.minute}");
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

  reorderDayList() {
    reorderPlacesList = [];
    reorderPlacesKeyList = [];

    reorderPlacesList.add("9:00AM The Place");
    reorderPlacesKeyList.add("The Place");
    reorderPlacesList.add("11:22AM The Second polkace");
    reorderPlacesKeyList.add("The Second polkace");
    reorderPlacesList.add("2:00PM The Sida");
    reorderPlacesKeyList.add("The Sida");
    reorderPlacesList.add("3:45PM Uglasia");
    reorderPlacesKeyList.add("Uglasia");

    // for (int i = 0; i < 3; i++) {
    //   countDay++;
    //   changeDayList.add(countDay.toString());
    // }
    // log("reorderPlacesList length ;: $reorderPlacesList");
    // log("reorderPlacesKeyList length ;: $reorderPlacesKeyList");
  }

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
      PlanDaysGetList? planDaysGetList = await planService.planDaysGetList();

      daysList.clear();
      if (planDaysGetList != null) {
        daysList = planDaysGetList.data;
        if (daysList.isNotEmpty) {
          selectedDayData = daysList.first;
          log("selectedDayData  is : ${selectedDayData!.day}");
        }
        log("daysList len is : ${daysList.length}");
        update();
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
      isLoading(true);

      permission = await Geolocator.requestPermission();
      currentLocation = await locateUser();

      PlanGetList? planGetList = await planService.planGetlistByDay(
        latitude: currentLocation.latitude,
        longitude: currentLocation.latitude,
        day: selectedDayData!.dayNumber,
      );
      planDataList.clear();

      if (planGetList != null) {
        planDataList = planGetList.data;
        // selectedDayData = daysList.first;
        log("planDataList len is : ${planDataList.length}");
        update();
      }

      update();
    } catch (e) {
      log("error is :: ${e.toString()}");
      rethrow;
    } finally {
      isLoading(false);
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
