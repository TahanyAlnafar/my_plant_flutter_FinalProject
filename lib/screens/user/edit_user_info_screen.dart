import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class EditUserInfoScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<MainProvider>(builder: (context, provider, c) {
          return provider.currentLoggedUser == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(AntDesign.arrowleft,
                                  color: kPrimaryColor),
                              onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                provider.updateUserImage();
                              },
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 9,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: provider.currentLoggedUser!.imageUrl == null ? Stack(
                                          children: [ Opacity(
                                            opacity: 0.5,
                                              child: CircleAvatar(
                                                  radius: 100.0,
                                                  backgroundImage: AssetImage(
                                                      "assets/images/user.png")),
                                            ),
                                            Center(
                                              child: Icon(Icons.camera),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                              child: CircleAvatar(
                                                  radius: 100.0,
                                                  backgroundImage: NetworkImage(
                                                    provider.currentLoggedUser!
                                                        .imageUrl!,
                                                  )),
                                            ),
                                            Center(
                                              child: Icon(Icons.camera),
                                            ),
                                          ],
                                        )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProfileItem(
                                'userName:',
                                ((provider.currentLoggedUser!.userName!)),
                                provider.profileUserNameController,
                                TextInputType.name),
                            ProfileItem(
                              'userAddress:',
                              ((provider.currentLoggedUser!.userAddress!)),
                              provider.profileUserAddressController,
                              TextInputType.text,
                            ),
                            ProfileItem(
                              'Phone Number:',
                              ((provider.currentLoggedUser!.userPhone!)),
                              provider.profilePhoneController,
                              TextInputType.phone,
                            ),
                            ProfileItem(
                                'Email:',
                                ((provider.currentLoggedUser!.userEmail!)),
                                provider.profileEmailController,
                                TextInputType.emailAddress,
                                true),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  bool isValid =
                                      formKey.currentState!.validate();
                                  if (isValid) {
                                    provider.updateUserInfo();
                                  }
                                },
                                child: Text(
                                  'Update User Info',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Gordita_thin',
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  String label;
  String content;
  TextEditingController controller;
  bool? readOnlyOption;
  TextInputType? keyboardType;

  ProfileItem(this.label, this.content, this.controller, this.keyboardType,
      [this.readOnlyOption]);

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: kPrimaryColor)),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
              enabled: label != 'Email:',
              keyboardType: keyboardType,
              focusNode: myFocusNode,
              decoration: InputDecoration(
                helperText:
                    label == 'Email:' ? '* sorry you cant change Email' : '',
                helperStyle: TextStyle(color: Colors.red, fontSize: 15),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              readOnly: readOnlyOption == null ? false : true,
              cursorColor: kPrimaryColor,
              validator: (String? x) {
                if (x == null || x.isEmpty) {
                  return "this field is required";
                }
              },
              controller: controller,
              style: TextStyle(fontSize: 18)),
        ),
      ]),
    );
  }
}
