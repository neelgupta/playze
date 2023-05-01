import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_your_account_controller.dart';

class CreateYourAccountView extends GetView<CreateYourAccountController> {
  const CreateYourAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateYourAccountView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateYourAccountView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
