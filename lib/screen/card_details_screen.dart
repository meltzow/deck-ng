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
                      ? const Center(child: Text('loading'))
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
                                    title: const Text(
                                      "Title",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14,
                                        color: Color(0xff424141),
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    subtitle: Text(
                                      controller.titleControllerText.value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
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
                                    leading: const Icon(Icons.title,
                                        color: Color(0xff3a57e8), size: 24),
                                    trailing: const Icon(Icons.edit,
                                        color: Color(0xff79797c), size: 22),
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
                                  tileColor: Color(0x00ffffff),
                                  title: Text(
                                    "Description",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: Text(
                                    controller.descriptionControllerText.value,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.all(0),
                                  selected: false,
                                  selectedTileColor: Color(0x42000000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  leading: Icon(Icons.subtitles,
                                      color: Color(0xff3a57e8), size: 24),
                                  trailing: Icon(Icons.edit,
                                      color: Color(0xff79797c), size: 22),
                                ),
                                Divider(
                                  color: Color(0xffdddddd),
                                  height: 20,
                                  thickness: 0,
                                  indent: 50,
                                  endIndent: 0,
                                ),
                                Card(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                          title: _editTitleTextField(
                                              controller.isTitleEditing,
                                              controller.titleControllerText,
                                              controller.titleController!),
                                          subtitle: _editTitleTextField(
                                              controller.isDescriptionEditing,
                                              controller
                                                  .descriptionControllerText,
                                              controller
                                                  .descriptionEditingController!)),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MultiSelectDialogField(
                                                title:
                                                    const Text('select labels'),
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

  Widget _editTitleTextField(RxBool isEditingField, RxString isEditingText,
      TextEditingController editingController) {
    if (isEditingField.value) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            isEditingText.value = newValue;
            isEditingField.value = false;
          },
          autofocus: true,
          controller: editingController,
        ),
      );
    }
    return InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          isEditingField.value = true;
        },
        child: Text(
          isEditingText.value,
        ));
  }
}
