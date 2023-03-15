import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

Drawer buildDrawerUser(
    BuildContext context, GlobalKey<ScaffoldState> drawerKey) {
  return Drawer(
    backgroundColor: "02075D".toColor(),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          left: 20.0,
          right: 12.0,
        ),
        child: SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            drawerKey.currentState?.closeDrawer();
                          },
                          child: const Icon(
                            Icons.close,
                            color: white,
                          ),
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: InkWell(
                      // onTap: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (_) => SDashboardNavigation(
                      //             selectedIndex: 3,
                      //           )));
                      // },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            color: white,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          customText(
                              text: 'Profile',
                              textColor: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        customText(
                            text: 'About us',
                            textColor: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.help_outline,
                          color: white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        customText(
                            text: 'Help',
                            textColor: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings_outlined,
                          color: white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        customText(
                            text: 'Settings',
                            textColor: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: InkWell(
                      onTap: () => launchUrl(
                          Uri.parse("https://www.praccel.com/privacy-policy/")),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.privacy_tip,
                            color: white,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          customText(
                              text: 'Privacy Policy',
                              textColor: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)
                        ],
                      ),
                    ),
                  ),
                  // kDebugMode ? getDrawerLoginTab() : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 30),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        //buildLogoutDialog(context);
                      },
                      child: Row(
                        children: [
                          // SvgPicture.asset(
                          //   logout,
                          //   color: lightBlack,
                          //   width: 18,
                          //   height: 18,
                          // ),
                          const SizedBox(
                            width: 18,
                          ),
                          customText(
                              text: 'LogOut',
                              textColor: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // FutureBuilder<PackageInfo>(
              //     future: PackageInfo.fromPlatform(),
              //     builder: (context, snapshot) {
              //       return customText(
              //           text: 'Version- ${snapshot.data?.version}',
              //           textColor: grey,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600);
              //     })
            ],
          ),
        ),
      ),
    ),
  );
}
