import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/custom_text.dart';

AppBar buildAppBarUser(
    GlobalKey<ScaffoldState> key, BuildContext context, selectedIndex) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: InkWell(
      onTap: () {
        selectedIndex == 0 ? key.currentState?.openDrawer() : Container();
        // : Navigator.of(context).pushReplacement(MaterialPageRoute(
        //     builder: (_) => SDashboardNavigation(
        //           selectedIndex: 0,
        //         )));
      },
      child: Container(
        width: 50,
        margin: const EdgeInsets.only(left: 14),
        child: Row(
          children: [
            selectedIndex != 0
                ? Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  )
                : const Icon(
                    Icons.menu,
                    color: white,
                  ),
          ],
        ),
      ),
    ),
    backgroundColor: "02075D".toColor(),
    elevation: 20.0,
    centerTitle: true,
    title: SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book,
            size: 22,
          ),
          const SizedBox(
            width: 5,
          ),
          customText(
              text: 'Edovation',
              textColor: white,
              fontWeight: FontWeight.bold,
              fontSize: 16)
        ],
      ),
    ),
    actions: [
      Icon(Icons.notifications_active),
      const SizedBox(
        width: 24,
      )
    ],
  );
}
