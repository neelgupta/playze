import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:playze/app/data/modal/common_message_data.dart';
import 'package:playze/app/data/modal/user_data_model.dart';

import 'package:playze/app/data/service/login_service.dart';
import 'package:playze/app/data/service/user_service.dart';
import 'package:playze/app/modules/profile/controllers/profile_controller.dart';

import '../../../../reusability/utils/shared_prefs.dart';
import '../../../data/modal/filters_model.dart';
import '../../../data/service/api_url_list.dart';

class EditProfileController extends GetxController {
  final count = 0.obs;
  File? imageFile;
  var isPicked = false.obs;
  List weekPrice = [];
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController yourLocation = TextEditingController();
  TextEditingController childrenName = TextEditingController();
  TextEditingController childrenAge = TextEditingController();
  var fnamestatus = false.obs;
  var emailstatus = false.obs;
  var phonestatus = false.obs;
  var yourLocationStatus = false.obs;
  var passwordstatus = false.obs;
  var cPasswordstatus = false.obs;
  List<TextEditingController> nameControllersList = [];
  List<TextEditingController> ageControllersList = [];
  String interests = "";
  List<String> selectedInterestIdList = [];
  List<String> idchildren = [];
  String idchildrens = "";
  String nameListString = "";
  String ageListString = "";
  String selectedInterestIdListSyting = "";
  String status = "";

  // var textFields = <TextField>[];
  // var textFieldss = <TextField>[];
  // var nameControllersList = <TextEditingController>[];
  // var ageControllersList = <TextEditingController>[];
  LoginService loginService = LoginService();
  String? id;
  List cname = [];
  List age = [];
  List<FilterData> interestsList = [];
  List<ChildrenDetails> childrenList = [];
  List<String>? tokan;
  UserService userService = UserService();
  var isLoading = false.obs;
  UserDataModal? profileData;
  FiltersModel? filtersModel;

  @override
  void onInit() {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    log("id : $id");
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    getUserData();
    // });
  }

  void selectFile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      isPicked.value = true;
      log("imageFile : $imageFile");
      update();
    }
  }

  Future<void> updateUserProfileDetails() async {
    String newtokan = tokan![1];
    // Interest = selectedInterestIdList.map((e) => e).toList().join(",");
    isLoading(true);
    cname.clear();
    for (var tc in nameControllersList) {
      log("tc : ${tc.text}");
      cname.add(tc.text.trim());
      // log(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    nameListString = cname.map((e) => e).toList().join(",");
    log("nameListString : ${nameListString.toString()}");

    age.clear();
    for (var tc in ageControllersList) {
      log("tc : ${tc.text}");
      age.add(tc.text.trim());
      // log(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    ageListString = age.map((e) => e).toList().join(",");
    log("ageListString : ${ageListString.toString()}");

    selectedInterestIdListSyting =
        selectedInterestIdList.map((e) => e).toList().join(",");

    // if (imageFile != null) {
    try {
      Map<String, String> data = {
        "id": id!,
        "full_name": name.text.trim(),
        "email": email.text.trim(),
        "phone_number": phoneNumber.text.trim(),
        "location": yourLocation.text.trim(),
        "children_name": nameListString,
        "children_age": ageListString,
        "interest": selectedInterestIdListSyting
      };
      var postUri = Uri.parse(ApiUrlList.userAddprofile);
      var request = http.MultipartRequest("POST", postUri);
      request.headers['Authorization'] = "Bearer $newtokan";
      request.fields.addAll(data);
      if (imageFile != null) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('image', imageFile!.path);
        request.files.add(multipartFile);
      } else {
        // http.MultipartFile multipartFile = http.MultipartFile.fromString(
        //   'image',
        //   "",
        // );
        // request.files.add(multipartFile);
        // request.fields["image"] = "";
      }
      log('request.fields : ${request.fields}');
      log('request.files : ${request.files}');
      http.StreamedResponse response = await request.send();
      log('code: ${response.statusCode}');
      final res = await http.Response.fromStream(response);
      log('body: ${res.body}');
      log("add profile body : ${res.body}");
      Map map = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (map['status'] == 200) {
          Get.back();
          if (Get.isRegistered<ProfileController>()) {
            var profileController = Get.find<ProfileController>();
            profileController.getUserProfileData();
          }
          Fluttertoast.showToast(
              msg: '${map['message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          idchildren.clear();
          ageListString = "";
          nameListString = "";
          Fluttertoast.showToast(
              msg: '${map['message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Something went wrong.Please try again later...!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getUserData() async {
    isLoading(true);
    nameListString = "";
    ageListString = "";
    idchildren.clear();
    nameControllersList.clear();
    ageControllersList.clear();
    await getInterestList().then((value) async {
      await userService.getUserDetailsMethod(id).then((value) {
        profileData = value;
        update();
      });
    });

    for (var interest in interestsList) {
      if (profileData!.data.interest.isNotEmpty) {
        for (var item in profileData!.data.interest) {
          if (item.id == interest.id) {
            interest.isSelected = true;
            selectedInterestIdList.add(interest.id);
            log("item.id interest.id : ${item.id}  ${interest.id}");
            log("item.id == interest.id : ${item.id == interest.id}");
          }
          // nameControllersList.add(TextEditingController(text: item.name));
        }
      }
      if (profileData != null) {
        populateData();
      }
    }

    log("nameControllersList is : ${nameControllersList.length}");
    log("ageControllersList is : ${ageControllersList.length}");
    // final response = await http.get(Uri.parse(data!.data.image.toString()));
    // final documentDirectory = await getApplicationDocumentsDirectory();
    // imageFile = File((documentDirectory.path));
    // imageFile!.writeAsBytesSync(response.bodyBytes);
    // YourLocation.text = loc!;
    update();
    isLoading(false);
  }

  populateData() {
    // var teController = TextEditingController();
    // teController.text = data!.data.name;
    nameControllersList.clear();
    ageControllersList.clear();
    name.text = profileData!.data.name;
    // Name.text = data!.data.name;
    email.text = profileData!.data.email;
    phoneNumber.text = profileData!.data.mobileNumber;
    yourLocation.text = profileData!.data.location;
    if (profileData!.data.children.isNotEmpty) {
      // for (var item in data!.data.children) {
      log("data!.data.children len is : ${profileData!.data.children.length}");
      for (var element in profileData!.data.children) {
        idchildren.add(element.id);
        // lip.add(element.name);
        nameControllersList.add(TextEditingController(text: element.name));
        ageControllersList.add(TextEditingController(text: element.age));
      }
      // }
    }
    update();
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try {
      CommonMessageData? deleteChild =
          await userService.deleteChildrenOfUserMethod(
        {"id": id},
      );
      if (deleteChild != null) {
        if (deleteChild.status == 200) {
          Fluttertoast.showToast(
              msg: deleteChild.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: deleteChild.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
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
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getInterestList() async {
    // isLoading(true);
    try {
      filtersModel = await loginService.getInterestsMethod();

      if (filtersModel != null) {
        for (var element in filtersModel!.data) {
          interestsList.add(element);
          // lip.add(element.name);
        }
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
      log(e.toString());
    } finally {
      // isLoading(false);
    }
  }
}
