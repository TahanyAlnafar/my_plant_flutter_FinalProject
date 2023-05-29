import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import 'package:my_plant_flutter_app/screens/authentaication/login_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';
import '../../../Custom/custom_pass_textfield.dart';
import '../../../Custom/custom_textfield.dart';
import '../../../Sizing/size_config.dart';
import '../../../components/already_have_an_account_acheck.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Consumer<MainProvider>(builder: (context, provider, x) {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.registerUserNameController, 'User Name','',
              TextInputType.name, true,Icons.person),
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.registerUserAddressController, 'Address','',
              TextInputType.text, true,Icons.map),
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.registerEmailController, 'Email','',
              TextInputType.emailAddress,true, Icons.email),
          SizedBox(
            height: 20,
          ),
          CustomPassTextField(provider.registerPasswordController, 'signup', Icons.lock),
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.registerPhoneNumController, 'Phone Number','',
              TextInputType.phone,true, Icons.phone),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              provider.register();
            },
            child: const Text("SIGN UP"),
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: (width <= 550)
                  ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                  : EdgeInsets.symmetric(
                      horizontal: width * 0.2, vertical: 25),
              textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      );
    });
  }
}

