import 'package:flutter/material.dart';

class InputJudulPengeluaran extends StatelessWidget {
  const InputJudulPengeluaran({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: _onSaveTitleInput,
      controller: titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text("Judul Pengeluaran")),
    );
  }
}
