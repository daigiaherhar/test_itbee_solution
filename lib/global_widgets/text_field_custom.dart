import 'package:flutter/material.dart';

import '../dialogs/dialog_core.dart';
import 'package:intl/intl.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.label,
    this.isShowDateTime = false,
    required this.controller,
    this.onChangeFunction,
  });

  final String? label;
  final bool isShowDateTime;
  final TextEditingController controller;
  final Function(String?)? onChangeFunction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label ?? ""),
      // enabled: !isShowDateTime,
      canRequestFocus: !isShowDateTime,
      onChanged: (text) {},
      // keyboardType:,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Vui lòng nhập đầy đủ";
        }
        return null;
      },
      onTap:
          isShowDateTime
              ? () async {
                DateTime? dateTime = await DialogCore.showDateTime();
                if (dateTime != null) {
                  String formattedDate = DateFormat(
                    "dd-MM-yyyy HH:mm",
                  ).format(dateTime);
                  controller.text = formattedDate;
                }
              }
              : null,
    );
  }
}
