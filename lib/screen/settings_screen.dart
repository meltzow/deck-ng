import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Settings".tr,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
          ),
        ),
        leading: Icon(
          Icons.arrow_back_ios,
          size: 22,
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16),
        shrinkWrap: false,
        physics: ScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Avatar",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Container(
                    height: 30,
                    width: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                        "https://image.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0x4d9e9e9e),
            height: 16,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Name",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "Philip Ramirez",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff000000),
                  size: 18,
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0x4d9e9e9e),
            height: 16,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Change Password",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "********",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff000000),
                  size: 18,
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0x4d9e9e9e),
            height: 16,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Email",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Text(
                    "philipramirez@gmail.com",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: Color(0xff9e9e9e),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff000000),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
