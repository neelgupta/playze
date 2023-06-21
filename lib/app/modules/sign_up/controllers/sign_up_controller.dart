import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  // var fnamestatus = false.obs;
  // var lnamestatus = false.obs;
  // var emailstatus = false.obs;
  // var phonestatus = false.obs;
  // var passwordstatus = false.obs;
  // var cPasswordstatus = false.obs;

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  // String status = "";
}
