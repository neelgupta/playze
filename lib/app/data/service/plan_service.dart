import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';

import '../../../reusability/utils/shared_prefs.dart';
import '../modal/plan_days_get_list.dart';
import '../modal/plan_get_list.dart';
import 'api_url_list.dart';

class PlanService {
  List<String>? tokan =
      SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

  Future<PlanDaysGetList?> planDaysGetListMethod({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.planDayGetlist;
    String newtokan = tokan![1];
    log("api url :; $url");
    log("newtokan :; $newtokan");
    var result = await NetworkHandler().get(url, client, newtokan);
    log("planDaysGetListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return PlanDaysGetList.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      throw Exception("Error getting plan days list");
    }
  }

  Future<PlanGetList?> planGetlistByDayMethod(
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
    log("planGetlistByDayMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return PlanGetList.fromJson(jsonDecode(result));
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool?> addPlanToDayMethod({placeId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.addPlanToDay;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {
        "place_id": placeId,
        "day": dayNumber,
      },
    );
    log("addPlanToDayMethod result is $result");
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
          fontSize: 16.0,
        );
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool?> addDayToListMethod({placeId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.dayAddToList;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler().post(url, client, newtokan);
    log("addDayToListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
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

  Future<bool?> deleteDayFromListMethod({dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.dayDeleteFromList;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler()
        .post(url, client, newtokan, model: {"day": dayNumber});
    log("deleteDayFromListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
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

  Future<bool?> planDeleteFromListMethod({planId, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planDeleteFromlist;
    log("url is :; $url");
    log("token $newtokan");
    var result = await NetworkHandler()
        .post(url, client, newtokan, model: {"plan_id": planId});
    log("planDeleteFromListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
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

  Future<bool?> planDayChangeApiMethod({planId, dayNumber, client}) async {
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
    log("planDayChangeApiMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return true;
      } else {
        Fluttertoast.showToast(
            msg: '${resBody['message']}',
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

  Future<bool?> planReorderInDayApiMethod(
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

    log("planReorderInDayApiMethodmodel : $model");

    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: model,
    );
    log("planReorderInDayApiMethod result is $result");
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

  Future<bool?> changeStartTimeOfPlanInDayApiMethod(
      {startTime, planId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planStartTime;
    log("url is :; $url");
    log("token $newtokan");
    var model = {
      "start_time": startTime,
      "plan_id": planId,
      "day": dayNumber,
    };

    log("changeStartTimeOfPlanInDayApiMethod : $model");

    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: model,
    );
    log("changeStartTimeOfPlanInDayApiMethod result is $result");
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

  Future<bool?> changeTimeDurationOfPlanInDayApiMethod(
      {durationTime, planId, dayNumber, client}) async {
    client ??= http.Client();
    String newtokan = tokan![1];
    var url = ApiUrlList.planDurationTime;
    log("url is :; $url");
    log("token $newtokan");
    var model = {
      "duration_time": durationTime,
      "plan_id": planId,
      "day": dayNumber,
    };

    log("changeTimeDurationOfPlanInDayApiMethod : $model");

    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: model,
    );
    log("changeTimeDurationOfPlanInDayApiMethod result is $result");
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
