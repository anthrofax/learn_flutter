import 'package:flutter/material.dart';
import 'package:learn_flutter/models/expense.dart';


class InputTanggal extends StatelessWidget {
  const InputTanggal({super.key, required this.onShowDatePicker, required this.selectedDate});

  final DateTime?  selectedDate;
  final void Function() onShowDatePicker;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(selectedDate != null
              ? formatter.format(selectedDate!)
              : "Tanggal"),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: onShowDatePicker,
              icon: const Icon(Icons.calendar_month)),
        ],
      ),
    );
  }
}
