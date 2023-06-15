import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/service/api_list.dart';

import '../../../Reusability/utils/shared_prefs.dart';
import '../modal/plan_days_get_list.dart';
import '../modal/plan_get_list.dart';

class PlanService {
  List<String>? tokan =
      SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

  Future<PlanDaysGetList?> planDaysGetList({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.planDayGetlist;
    String newtokan = tokan![1];
    log("api url :; $url");
    log("newtokan :; $newtokan");
    var result = await NetworkHandler().get(url, client, newtokan);
    log("planDaysGetList result is $result");
    if (result != null) {
      return PlanDaysGetList.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting plan days list");
    }
  }

  Future<PlanGetList?> planGetlistByDay(
      {day, longitude, latitude, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.planGetlistByDay;
    String newtokan = tokan![1];
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "longitude": longitude,
      "latitude": latitude,
      "day": day,
    });
    log("planGetlistByDay result is $result");
    if (result != null) {
      return PlanGetList.fromJson(jsonDecode(result));
    } else {
      return null;
    }
  }

  Future<bool?> addPlanToDay({placeId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.addPlanToDay;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "place_id": placeId,
      "day": dayNumber,
    });
    log("addPlanToDay result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);

      if (resBody["status"] == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: resBody["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool?> addDayToList({placeId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.dayAddToList;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(url, client, newtokan);
    log("addDayToList result is $result");
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> deleteDayFromList({dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.dayDeleteFromList;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler()
        .post(url, client, newtokan, model: {"day": dayNumber});
    log("deleteDayFromList result is $result");
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> planDeleteFromList({planId, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planDeleteFromlist;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler()
        .post(url, client, newtokan, model: {"plan_id": planId});
    log("planDeleteFromList result is $result");
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> planDayChangeApi({planId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planDayChange;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {
        "plan_id": planId,
        "day": dayNumber,
      },
    );
    log("planDayChangeApi result is $result");
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> planReorderInDayApi(
      {userId, oldIndexNumber, newIndexNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planDayReorder;
    log("url is :; $url");
    log("token $newtokan");
    var model = {
      "user_id": userId,
      "old_order_number": oldIndexNumber,
      "new_order_number": newIndexNumber,
    };

    log("model :  $model");

    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: model,
    );
    log("planReorderInDayApi result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody["status"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
