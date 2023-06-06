import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:playze/app/data/modal/class.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/userdata.dart';
import 'package:playze/app/data/service/Userservise.dart';
import 'package:playze/app/data/service/api_list.dart';
import 'package:playze/app/data/service/loginservice.dart';
import 'package:playze/app/modules/profile/controllers/profile_controller.dart';

import '../../../../Reusability/utils/shared_prefs.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final count = 0.obs;
  File? imageFile;
  var isPicked = false.obs;
  List weekPrice = [];
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController YourLocation = TextEditingController();
  TextEditingController ChildrenName = TextEditingController();
  TextEditingController ChildrenAge = TextEditingController();
  var fnamestatus = false.obs;
  var emailstatus = false.obs;
  var phonestatus = false.obs;
  var yourLocationStatus = false.obs;
  var passwordstatus = false.obs;
  var cPasswordstatus = false.obs;
  List<TextEditingController> nameControllersList = [];
  List<TextEditingController> ageControllersList = [];
  String Interest = "";
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
  loginService Loginervice = loginService();
  String? id;
  List cname = [];
  List age = [];
  List<dp> interestsList = [];
  List<ChildrenDetails> childrenList = [];
  List<String>? tokan;
  Usersevise usersevise = Usersevise();
  var isLoading = false.obs;
  DataModal? profileData;
  hp? b;

  @override
  void onInit() {
    super.onInit();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    print(id);
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    getAbout();
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectFile() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      isPicked.value = true;
      print(imageFile);
      update();
    }
  }

  Future<void> Addprofile() async {
    String newtokan = tokan![1];
    // Interest = selectedInterestIdList.map((e) => e).toList().join(",");
    isLoading(true);
    cname.clear();
    for (var tc in nameControllersList) {
      log("tc : ${tc.text}");
      cname.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    nameListString = cname.map((e) => e).toList().join(",");
    log("nameListString : ${nameListString.toString()}");

    age.clear();
    for (var tc in ageControllersList) {
      log("tc : ${tc.text}");
      age.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    ageListString = age.map((e) => e).toList().join(",");
    log("ageListString : ${ageListString.toString()}");

    selectedInterestIdListSyting =
        selectedInterestIdList.map((e) => e).toList().join(",");

    // if (imageFile != null) {
    try {
      Map<String, String> data = {
        "id": id!,
        "full_name": Name.text.trim(),
        "email": Email.text.trim(),
        "phone_number": PhoneNumber.text.trim(),
        "location": YourLocation.text.trim(),
        "children_name": nameListString,
        "children_age": ageListString,
        // "image": imageFile.toString(),
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
      if (map['status'] == 200) {
        Get.back();
        if (Get.isRegistered<ProfileController>()) {
          var profileController = Get.find<ProfileController>();
          profileController.getAbout();
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
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
    // } else {
    //   isLoading(false);
    //   Fluttertoast.showToast(
    //       msg: 'please enter image',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.blue,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  Future<void> getAbout() async {
    isLoading(true);
    nameListString = "";
    ageListString = "";
    idchildren.clear();
    nameControllersList.clear();
    ageControllersList.clear();
    await getinterest().then((value) async {
      await usersevise.getdata(id).then((value) {
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
    Name.text = profileData!.data.name;
    // Name.text = data!.data.name;
    Email.text = profileData!.data.email;
    PhoneNumber.text = profileData!.data.mobileNumber;
    YourLocation.text = profileData!.data.location;
    if (profileData!.data.children.isNotEmpty) {
      // for (var item in data!.data.children) {
      log("data!.data.children len is : ${profileData!.data.children.length}");
      profileData?.data.children.forEach((element) {
        idchildren.add(element.id);
        // lip.add(element.name);
        nameControllersList.add(TextEditingController(text: element.name));
        ageControllersList.add(TextEditingController(text: element.age));
      });
      // }
    }
    update();
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try {
      Commonmsg? sigin = await usersevise.deletechildren({"id": id});
      if (sigin?.status == 200) {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> getinterest() async {
    // isLoading(true);
    try {
      b = await Loginervice.getinterest();
      b?.data.forEach((element) {
        interestsList.add(element);
        // lip.add(element.name);
      });
      // b?.data.forEach((element) {
      //   interestsList.add(element);
      //   // lip.add(element.name);
      // });
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      // isLoading(false);
    }
  }
}
