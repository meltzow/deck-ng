import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget _editTitleTextField(RxBool isEditingField, RxString isEditingText,
    TextEditingController editingController) {
  if (isEditingField.value) {
    return Center(
        child: Focus(
      child: TextField(
        onSubmitted: (newValue) {
          isEditingText.value = newValue;
          isEditingField.value = false;
        },
        autofocus: true,
        controller: editingController,
      ),
      onFocusChange: (hasFocus) {
        isEditingField.value = hasFocus;
      },
    ));
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
