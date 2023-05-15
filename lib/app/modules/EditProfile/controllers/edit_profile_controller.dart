

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:playze/app/data/modal/comman.dart';
import 'package:playze/app/data/modal/userdata.dart';
import 'package:playze/app/data/service/Api_list.dart';
import 'package:http/http.dart' as http;
import 'package:playze/app/data/service/Userservise.dart';
import 'package:playze/app/modules/profile/controllers/profile_controller.dart';
import 'package:playze/app/routes/app_pages.dart';

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
  List<TextEditingController> nameControllersList = [];
  List<TextEditingController> ageControllersList = [];
  String Interest = "";
  List<String> selectedInterestIdList = [];
  List <String> idchildren = [];
  String idchildrens = "";
  String nameListString = "";
  String ageListString = "";
  // var textFields = <TextField>[];
  // var textFieldss = <TextField>[];
  // var nameControllersList = <TextEditingController>[];
  // var ageControllersList = <TextEditingController>[];
  String? id;
  String? name;
  String? email;
  String? pnamubar;
  String? loc;
  List cname = [];
  List age = [];
  List<Children> childrenList = [];
  List<String> ? tokan;
  Usersevise usersevise = Usersevise();
  RxBool isLoading = false.obs;
  DataModal? a;
  @override
  void onInit() {
    super.onInit();
    id = SharedPrefs().value.read(SharedPrefs.userIdKey);
    print(id);
    tokan = SharedPrefs().value.read(SharedPrefs.tokenKey).split("|");
    getAbout();
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
    nameListString = "";
    ageListString = "";
    isLoading(true);
    for(var tc in nameControllersList){
      log("tc : ${tc.text}");
      cname.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }

    nameListString = cname.map((e) => e).toList().join(",");
    log("ageControllersList : ${nameListString.toString()}");
    for(var tc in ageControllersList){
      log("tc : ${tc.text}");
      age.add(tc.text.trim());
      // print(list.toString().replaceAll('[', '').replaceAll(']',''))
    }
    ageListString = age.map((e) => e).toList().join(",");
    log("ageControllersList : ${ageListString.toString()}");
    if(imageFile != null){
      try{
        Map<String, String> data = {
          "id": id!,
          "full_name": Name.text.trim(),
          "email": Email.text.trim(),
          "phone_number": PhoneNumber.text.trim(),
          "location": YourLocation.text.trim(),
          "children_name": nameListString,
          "children_age": ageListString,
        };
        var postUri = Uri.parse(ApiURLList.userAddprofile);
        var request = http.MultipartRequest("POST", postUri);
        request.headers['Authorization'] = "Bearer ${newtokan}";
        request.fields.addAll(data);
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', imageFile!.path);
        request.files.add(multipartFile);
        http.StreamedResponse response = await request.send();
        print('code: ${response.statusCode}');
        final res = await http.Response.fromStream(response);
        print('body: ${res.body}');
        Map map = jsonDecode(res.body);
        if (map['status'] == 200) {
          Get.back();
          if(Get.isRegistered<ProfileController>()){
          var profileController = Get.find<ProfileController>();
          profileController.getAbout();
          }

          Fluttertoast.showToast(
              msg: '${map['message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else {
          Fluttertoast.showToast(
              msg: '${map['message']}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
      catch(e){
        rethrow;
      }
      finally{
        isLoading(false);
      }
    }else{
      isLoading(false);
      Fluttertoast.showToast(
          msg: 'please enter image',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> getAbout() async {
    isLoading(true);
    try {
      idchildren.clear();
      nameControllersList.clear();
      ageControllersList.clear();
      a = await usersevise.getdata(id);
        name = a?.data.name;
        email = a?.data.email;
        pnamubar = a?.data.mobileNumber;
        loc = a?.data.location;
        if(a!.data.children.isNotEmpty){
          for(var item in a!.data.children){
            a?.data.children.forEach((element) {
              idchildren.add(element.id);
              // lip.add(element.name);
            });
            nameControllersList.add(TextEditingController(text: item.name));
            ageControllersList.add(TextEditingController(text: item.age));
            print(nameControllersList);
            print(ageControllersList);
          }
        }
      Name.text = name!;
      Email.text = email!;
      PhoneNumber.text = pnamubar!;
      YourLocation.text = loc!;
        print(name);print(email);print(pnamubar);
      update();
    } catch (e) {
      print("${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> userdeletechildren(id) async {
    isLoading(true);
    try{
      Commonmsg? sigin = await usersevise.getdeletechildren({
        "id": id
      });
      if (sigin?.status == 200) {
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else{
        Fluttertoast.showToast(
            msg: '${sigin?.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    catch(e){
      rethrow;
    }
    finally{
      isLoading(false);
    }
  }

}
