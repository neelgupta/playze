import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/aboutclass.dart';
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
      return true;
    } else {
      return false;
    }
  }

  Future<AboutModel?> getAboutus({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.aboutus;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getinterest result is $result");
    if (result != null) {
      return AboutModel.fromJson(jsonDecode(result));
    } else {
      throw Exception("Error getting agreement list");
    }
  }
}
