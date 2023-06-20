import 'package:deck_ng/model/card.dart' as NC;
import 'package:deck_ng/screen/board_details_screen.dart';
import 'package:flutter/material.dart';

class ListViewCardItem extends StatefulWidget {
  final NC.Card? data;

  const ListViewCardItem({Key? key, required this.data}) : super(key: key);

  @override
  State<ListViewCardItem> createState() => _ListViewCardItemState();
}

class _ListViewCardItemState extends State<ListViewCardItem> {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    // _isChecked = widget.data.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.data != null ? widget.data!.title : "",
      ),
      onTap: () {
        // When the user taps the button,
        // navigate to a named route and
        // provide the arguments as an optional
        // parameter.
        Navigator.pushNamed(
          context,
          '/boards/details',
          arguments: ScreenArguments(
            widget.data != null ? widget.data!.id : -1,
            'This message is extracted in the build method.',
          ),
        );
      },
    );
  }
}
