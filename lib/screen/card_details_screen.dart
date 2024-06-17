import 'package:deck_ng/controller/card_details_controller.dart';
import 'package:deck_ng/model/card.dart' as card_model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailsScreen extends StatelessWidget {
  final CardDetailsController cardController =
      Get.find<CardDetailsController>();

  CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: cardController.fetchCard,
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: cardController.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: cardController.descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: cardController.duedateController,
                    decoration: const InputDecoration(labelText: 'Due Date'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: card.duedate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        cardController.duedateController.text =
                            selectedDate.toIso8601String();
                        cardController.card.value =
                            card.copyWith(duedate: selectedDate);
                      }
                    },
                  ),
                  _buildLabelsField(context, card),
                  _buildAssignedUsersField(context, card),
                  ElevatedButton(
                    onPressed: () {
                      cardController.updateCard(card);
                    },
                    child: const Text('Save'),
                  ),
                ],
              )),
        );
      }
    });
  }

  Widget _buildLabelsField(BuildContext context, card_model.Card card) {
    if (cardController.labels.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Labels'),
        ...card.labels.map((label) {
          return ListTile(
            title: Text(label.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cardController.removeLabel(label);
              },
            ),
          );
        }),
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
          title: Text('Add Label'),
          children: [
            ...cardController.labels.map((label) {
              return Obx(() {
                return CheckboxListTile(
                  title: Text(label.title),
                  value: cardController.selectedLabels.contains(label),
                  onChanged: (bool? value) {
                    if (value == true) {
                      cardController.selectedLabels.add(label);
                    } else {
                      cardController.selectedLabels.remove(label);
                    }
                  },
                );
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    cardController.selectedLabels.forEach((label) {
                      cardController.addLabel(label);
                    });
                    cardController.selectedLabels.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
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
        }),
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
                return CheckboxListTile(
                  title: Text(user.displayname),
                  value: cardController.card.value?.assignedUsers?.any(
                      (assignment) => assignment.participant.uid == user.uid),
                  onChanged: (bool? value) {
                    if (value == true) {
                      cardController.addUser(user);
                    } else {
                      cardController.removeUser(user);
                    }
                  },
                );
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
