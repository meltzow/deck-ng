// lib/card/card_details_screen.dart

import 'package:deck_ng/card_details/card_details_controller.dart';
import 'package:deck_ng/model/card.dart' as card_model;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardDetailsScreen extends StatelessWidget {
  final CardDetailsController cardController =
      Get.find<CardDetailsController>();
  final FocusNode descriptionFocusNode = FocusNode();

  CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    descriptionFocusNode.addListener(() {
      if (!descriptionFocusNode.hasFocus) {
        cardController.isEditMode.value = false;
      }
    });

    return Obx(() {
      final card = cardController.card.value;
      if (card == null) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Card Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: cardController.refreshData,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: cardController.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 16.0),
                  _buildDescriptionField(context, card),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cardController.duedateController,
                          decoration:
                              const InputDecoration(labelText: 'Due Date'),
                          readOnly: true,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: card.duedate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (selectedDate != null) {
                              final DateFormat formatter = DateFormat.yMd(
                                  Localizations.localeOf(context).toString());
                              cardController.duedateController.text =
                                  formatter.format(selectedDate);
                              cardController.card.value =
                                  card.copyWith(duedate: selectedDate);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: cardController.clearDueDate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  _buildLabelsField(context, card),
                  const SizedBox(height: 16.0),
                  _buildAssignedUsersField(context, card),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      cardController.updateCard(card);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildDescriptionField(BuildContext context, card_model.Card card) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: cardController.isEditMode.value
                ? SingleChildScrollView(
                    child: TextField(
                      controller: cardController.descriptionController,
                      focusNode: descriptionFocusNode,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: null,
                      onChanged: (text) {
                        cardController.updateMarkdownPreview(text);
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      cardController.isEditMode.value = true;
                      descriptionFocusNode.requestFocus();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Description'),
                          MarkdownBody(
                            data: cardController.markdownPreview.value,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          IconButton(
            icon: Icon(
                cardController.isEditMode.value ? Icons.preview : Icons.edit),
            onPressed: () {
              cardController.isEditMode.value =
                  !cardController.isEditMode.value;
              if (cardController.isEditMode.value) {
                descriptionFocusNode.requestFocus();
              } else {
                descriptionFocusNode.unfocus();
              }
            },
          ),
        ],
      );
    });
  }

  Widget _buildLabelsField(BuildContext context, card_model.Card card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Labels'),
        ...card.labels.map((label) {
          return ListTile(
            title: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: label.color1,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cardController.removeLabel(label);
              },
            ),
          );
        }).toList(),
        ElevatedButton(
          onPressed: () {
            _addLabelDialog(context);
          },
          child: const Text('Add Label'),
        ),
      ],
    );
  }

  void _addLabelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Label'),
          children: [
            ...cardController.labels.map((label) {
              return SimpleDialogOption(
                onPressed: () {
                  cardController.addLabel(label);
                  Navigator.pop(context);
                },
                child: Text(label.title),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildAssignedUsersField(BuildContext context, card_model.Card card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Assigned Users'),
        ...?card.assignedUsers?.map((assignment) {
          return ListTile(
            title: Text(assignment.participant.displayname),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cardController.removeUser(assignment.participant);
              },
            ),
          );
        }).toList(),
        ElevatedButton(
          onPressed: () {
            _addUserDialog(context);
          },
          child: const Text('Add User'),
        ),
      ],
    );
  }

  void _addUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add User'),
          children: [
            ...cardController.users.map((user) {
              return Obx(() {
                bool isChecked = cardController.card.value?.assignedUsers?.any(
                        (assignment) =>
                            assignment.participant.uid == user.uid) ??
                    false;
                return CheckboxListTile(
                  title: Text(user.displayname),
                  value: isChecked,
                  onChanged: (bool? value) {
                    if (value == true) {
                      cardController.addUser(user);
                    } else {
                      cardController.removeUser(user);
                    }
                  },
                );
              });
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
