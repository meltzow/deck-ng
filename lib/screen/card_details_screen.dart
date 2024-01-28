import 'package:deck_ng/component/my_app_bar_widget.dart';
import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CardDetailsScreen extends StatelessWidget {
  final controller = Get.find<CardDetailsController>();

  CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "Card details",
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Color(0xffffffff),
                size: 22,
              ),
              onPressed: () {
                controller.refreshData();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Color(0xffffffff),
                size: 22,
              ),
              onPressed: () {
                controller.saveCard();
              },
            )
          ],
        ),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshData,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  margin: const EdgeInsets.only(top: 25),
                  child: Obx(() => controller.isLoading.value
                      ? Center(child: Text('loading'.tr))
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                            "https://cdn.pixabay.com/photo/2020/05/17/20/21/cat-5183427_960_720.jpg",
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(0),
                                        padding: const EdgeInsets.all(0),
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff3a57e8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.photo_camera,
                                          color: Color(0xffffffff),
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: ListTile(
                                    tileColor: const Color(0x00ffffff),
                                    title: TextField(
                                      controller: controller.titleController,
                                      decoration: InputDecoration(
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xff9e9e9e),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xff9e9e9e),
                                              width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xff9e9e9e),
                                              width: 1),
                                        ),
                                        labelText: "Title",
                                        labelStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16,
                                          color: Color(0xff9e9e9e),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xffffffff),
                                        isDense: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff424141),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(0),
                                    selected: false,
                                    selectedTileColor: const Color(0x42000000),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    leading: const Icon(Icons.title,
                                        color: Color(0xff3a57e8), size: 24),
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xffdddddd),
                                  height: 30,
                                  thickness: 0,
                                  indent: 50,
                                  endIndent: 0,
                                ),
                                ListTile(
                                  tileColor: const Color(0x00ffffff),
                                  title: TextField(
                                    controller:
                                        controller.descriptionEditingController,
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xff9e9e9e), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xff9e9e9e), width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xff9e9e9e), width: 1),
                                      ),
                                      labelText: "Description".tr,
                                      labelStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        color: Color(0xff9e9e9e),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffffffff),
                                      isDense: false,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  selected: false,
                                  selectedTileColor: const Color(0x42000000),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  leading: const Icon(Icons.subtitles,
                                      color: Color(0xff3a57e8), size: 24),
                                ),
                                const Divider(
                                  color: Color(0xffdddddd),
                                  height: 20,
                                  thickness: 0,
                                  indent: 50,
                                  endIndent: 0,
                                ),
                                Card(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MultiSelectDialogField(
                                                title: Text('select labels'.tr),
                                                items: controller.allLabel!
                                                    .map((e) => MultiSelectItem(
                                                        e, e.title))
                                                    .toList(),
                                                listType:
                                                    MultiSelectListType.CHIP,
                                                onConfirm: (values) =>
                                                    controller
                                                        .saveLabels(values)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                        ))),
            ),
          )
        ])));
  }
}
