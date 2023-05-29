import 'package:flutter/material.dart';
import 'package:my_plant_flutter_app/providers/admin_provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../app_routers/app_routers.dart';
import '../../constants.dart';
import 'edit_user_info_screen.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Consumer<MainProvider>(builder: (context, provider, c) {
      return provider.currentLoggedUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kPrimaryColor.withOpacity(0.09),
                        kPrimaryColor.withOpacity(0.09),
                      ],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(AntDesign.arrowleft,
                                      color: kPrimaryColor),
                                  onPressed: () => Navigator.pop(context)),
                              IconButton(
                                icon: Icon(AntDesign.logout,
                                    color: kPrimaryColor),
                                onPressed: () {
                                  AppRouter.showWarningLogOutDialog();
                                },
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.40,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.70,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 90,
                                            ),
                                            Text("@ " +
                                                  provider.currentLoggedUser!
                                                      .userName!,
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontFamily: 'Gordita_thin',
                                                fontSize: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'My plants',
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontFamily:
                                                            'Gordita_thin',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      provider.allPlants!.length.toString()!,
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontFamily:
                                                            'Gordita_Light',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: innerWidth * 0.05,
                                                ),
                                                Image.asset(
                                                  'assets/images/cactus2.png',
                                                  width: innerWidth * 0.1,
                                                  height: innerWidth * 0.1,
                                                  fit: BoxFit.contain,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 110,
                                      right: 20,
                                      child: IconButton(
                                          icon: Icon(
                                            AntDesign.setting,
                                            color: Colors.grey[700],
                                            size: 30,
                                          ),
                                          onPressed: () =>
                                              AppRouter.navigateToScreen(
                                                  EditUserInfoScreen())),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            child:
                                            provider.currentLoggedUser!.imageUrl == null ? const CircleAvatar(
                                                    radius: 70.0,
                                                    backgroundImage: AssetImage(
                                                        "assets/images/user.png"))
                                                : CircleAvatar(
                                                    radius: 60.0,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      provider
                                                          .currentLoggedUser!
                                                          .imageUrl!,
                                                    )),
                                            decoration: BoxDecoration(

                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 1)),
                                            width: MediaQuery.of(context).size.width * 0.4, // Adjust the multiplier as needed
                                            height: MediaQuery.of(context).size.width * 0.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: height * 0.32,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'My Info',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                      fontFamily: 'Gordita_Light',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 2.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 20),
                                            Text(
                                              'Email : ',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              provider.currentLoggedUser!
                                                  .userEmail!,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 20),
                                            const Text(
                                              'Address : ',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              provider.currentLoggedUser!
                                                  .userAddress!,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 20),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Phone : ',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              provider.currentLoggedUser!
                                                  .userPhone!,
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20,
                                                fontFamily: 'Gordita_Light',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
    }));
  }
}
