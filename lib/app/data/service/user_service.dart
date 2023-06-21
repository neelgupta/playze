import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:playze/app/data/Network/network.dart';
import 'package:playze/app/data/modal/common_message_data.dart';
import 'package:playze/app/data/modal/user_data_model.dart';
import 'package:playze/app/data/modal/workspace_detail_model.dart';
import 'package:playze/app/data/modal/place_data_model.dart';

import '../../../reusability/utils/shared_prefs.dart';
import '../modal/about_model.dart';
import '../modal/filters_model.dart';
import '../modal/get_category_filter_model.dart';
import '../modal/get_nearby_model.dart';
import '../modal/get_reviews_model.dart';
import '../modal/get_search_filter_model.dart';
import '../modal/wishlist_get_model.dart';
import '../modal/work_space_model.dart';
import 'api_url_list.dart';

class UserService {
  List<String>? tokan =
      SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");

  Future<CommonMessageData?> userChangePasswordMethod(
      id, opassword, npassword, cpassword,
      {client}) async {
    client ??= http.Client();
    log(ApiUrlList.userChangePassword);
    String newtokan = tokan![1];
    log(newtokan);
    var url = ApiUrlList.userChangePassword;
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "id": id,
      "old_password": opassword,
      "new_password": npassword,
      "password_confirmation": cpassword,
    });
    log("userChangePasswordMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return CommonMessageData.fromJson(jsonDecode(result));
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

  Future<CommonMessageData?> contactUsMethod(name, email, massage,
      {client}) async {
    client ??= http.Client();
    log(ApiUrlList.contactUs);
    String newtokan = tokan![1];
    log(newtokan);
    var url = ApiUrlList.contactUs;
    var result = await NetworkHandler().post(url, client, newtokan, model: {
      "name": name,
      "email": email,
      "message": massage,
    });
    log("contactUsMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return CommonMessageData.fromJson(jsonDecode(result));
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

  Future<FiltersModel?> getCategorylistMethod({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.categoryList;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getCategorylistMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return FiltersModel.fromjson(jsonDecode(result));
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
      throw Exception("Error getCategorylistMethod list");
    }
  }

  Future<AboutModel?> getAboutUsMethod({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.aboutus;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getAboutUsMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return AboutModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getAboutUsMethod list");
    }
  }

  Future<UserDataModal?> getUserDetailsMethod(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.userDetailes;
    String newtokan = tokan![1];
    log("getUserDetailsMethod id : $id");
    log(newtokan);
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {"id": id},
    );
    log("getUserDetailsMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return UserDataModal.fromJson(jsonDecode(result));
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
      throw Exception("Error getUserDetailsMethod list");
    }
  }

  Future<CommonMessageData?> deleteChildrenOfUserMethod(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.deleteChildren;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {"id": id},
    );
    log("deleteChildrenOfUserMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return CommonMessageData.fromJson(jsonDecode(result));
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
      throw Exception("Error deleteChildrenOfUserMethod list");
    }
  }

  Future<PlaceDataModel?> getAllPlacesListMethod(
      {latitudeValue, longitudeValue, client}) async {
    client ??= http.Client();
    var url =
        "${ApiUrlList.placesActiveList}?latitude=$latitudeValue&longitude=$longitudeValue";
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getAllPlacesListMethod result is : $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return PlaceDataModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getAllPlacesListMethod list");
    }
  }

  Future<WorkSpaceDetailModel?> getPlaceDetailsMethod(id, {client}) async {
    client ??= http.Client();
    var url = ApiUrlList.plaseDetails;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {"id": id},
    );
    log("getPlaceDetailsMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return WorkSpaceDetailModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getPlaceDetailsMethod list");
    }
  }

  Future<GetNearByModel?> getNearbyPlacesMethod({placeId, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.nearbyPlaces;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {
        "place_id": placeId,
      },
    );
    log("getNearbyPlacesMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return GetNearByModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getting getNearbyPlaces list");
    }
  }

  Future<GetReviewsModel?> getPlaceReviewsMethod({placeId, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.pleaseReview;
    String newtokan = tokan![1];
    log(newtokan);
    log("getPlaceReviews url is $url");
    log("getPlaceReviews placeId is $placeId");
    var result = await NetworkHandler()
        .post(url, client, newtokan, model: {"places_id": placeId});
    log("getPlaceReviews result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return GetReviewsModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getPlaceReviews list");
    }
  }

  Future<WorkSpaceListModel?> getWorkSpacesListMethod({client}) async {
    client ??= http.Client();
    var url = ApiUrlList.getWorkspace;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().get(url, client, newtokan);
    log("getWorkSpacesListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return WorkSpaceListModel.fromJson(jsonDecode(result));
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
      throw Exception("Error getWorkSpacesListMethod list");
    }
  }

  Future<bool?> addWorkSpaceToMyWorkSpaceMethod(
      {userId, placesId, status, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.addWorkSpace;
    String newtokan = tokan![1];

    var reqBody = {
      "user_id": userId,
      "places_id": placesId,
      "status": status,
    };
    log("addWorkSpaceToMyWorkSpace token :: $newtokan");
    log("addWorkSpaceToMyWorkSpace reqBody :: $reqBody");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: reqBody,
    );
    log("addWorkSpaceToMyWorkSpace result is :: $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody["status"] == 200) {
        Fluttertoast.showToast(
            msg: resBody["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: resBody["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return true;
    } else {
      // throw Exception("Error adding workspace");
      return false;
    }
  }

  Future<GetCategoryFilterModel?> categoryFilterGetListMethod(
      {required categoryFilterIdList,
      required latitude,
      required longitude,
      client}) async {
    client ??= http.Client();
    var url = ApiUrlList.categoryPlaceFilter;
    String newtokan = tokan![1];

    var reqBody = {
      "category_filter": categoryFilterIdList,
      "latitude": latitude,
      "longitude": longitude,
    };
    log("categoryFilterGetList token :: $newtokan");
    log("categoryFilterGetList reqBody :: $reqBody");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: reqBody,
    );
    log("categoryFilterGetList result is :: $result");
    if (result != null) {
      // var data = GetCategoryFilterModel.fromJson(jsonDecode(result));
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return GetCategoryFilterModel.fromJson(jsonDecode(result));
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
      throw Exception("Error categoryFilterGetList");
      // return Exception("Error getting agreement list");
    }
  }

  Future<GetSearchFilterModel?> searchDataGetListMethod(
      {required searchData, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.searchFilter;
    String newtokan = tokan![1];

    var reqBody = {
      "search": searchData,
    };
    log("searchDataGetList token :: $newtokan");
    log("searchDataGetList reqBody :: $reqBody");
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: reqBody,
    );
    log("searchDataGetList result is :: $result");
    if (result != null) {
      // var data = GetCategoryFilterModel.fromJson(jsonDecode(result));
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return GetSearchFilterModel.fromJson(jsonDecode(result));
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
      throw Exception("Error searchDataGetList");
      // return Exception("Error getting agreement list");
    }
  }

  Future<bool?> addToWishListMethod({
    placeId,
    userId,
    status,
    client,
  }) async {
    client ??= http.Client();
    var url = ApiUrlList.addToWishlist;
    String newtokan = tokan![1];
    log(newtokan);
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {
        "places_id": placeId,
        "user_id": userId,
        "status": status,
      },
    );
    log("addToWishListMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);

      if (resBody["status"] == 200) {
        Fluttertoast.showToast(
          msg: resBody["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
      throw Exception("Error addToWishListMethod list");
    }
    // return null;
  }

  Future<WishListGetModel?> wishListGetMethod({userId, client}) async {
    client ??= http.Client();
    var url = ApiUrlList.getWishList;
    String newtokan = tokan![1];
    log(newtokan);

    var model = {
      "user_id": userId,
    };
    var result = await NetworkHandler().post(
      url,
      client,
      newtokan,
      model: {
        "user_id": userId,
      },
    );
    log("wishListGetMethod model is  $model");
    log("wishListGetMethod result is $result");
    if (result != null) {
      var resBody = jsonDecode(result);
      if (resBody['status'] == 200) {
        return WishListGetModel.fromJson(jsonDecode(result));
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
      throw Exception("Error wishListGetMethod list");
    }
  }
}
