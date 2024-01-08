import 'package:deck_ng/component/board_item_widget.dart';
import 'package:deck_ng/controller/board_overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BoardOverviewController controller =
        Get.put<BoardOverviewController>(BoardOverviewController());

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3a57e8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xfff9f9f9),
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Color(0xffffffff), size: 22),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
            child: Icon(Icons.dashboard, color: Color(0xffffffff), size: 22),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Boards",
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
                Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  height: 170,
                  decoration: const BoxDecoration(
                    color: Color(0x00ffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.boardDataCount,
                      itemBuilder: (context, index) {
                        return BoardItemWidget(
                            board: controller.boardData[index]);
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    "Notes",
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
                GridView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  children: [
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.push_pin,
                                color: Color(0xffffc000),
                                size: 24,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Web Ideas ",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Ideas",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 16,
                                width: 16,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "The Role of creativity in UX design?",
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "UX",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 16,
                                width: 16,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Chap 1",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Story",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.push_pin,
                                color: Color(0xffffc000),
                                size: 24,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Chap 2",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Ideas",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.push_pin,
                                color: Color(0xffffc000),
                                size: 24,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Web Ideas ",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Ideas",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.push_pin,
                                color: Color(0xffffc000),
                                size: 24,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Chap 3 ",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Story",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x00ffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: const Color(0x4d9e9e9e), width: 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.push_pin,
                                color: Color(0xffffc000),
                                size: 24,
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Color(0xff212435),
                                size: 24,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              "Web Ideas ",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x343a57e8),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Ideas",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 16),
              padding: const EdgeInsets.all(0),
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xff3a57e8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xffffffff),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
