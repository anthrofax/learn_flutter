import 'package:flutter/material.dart';

class InputNilaiPengeluaran extends StatelessWidget {
  const InputNilaiPengeluaran({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // onChanged: _onSaveTitleInput,
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          label: Text("Nilai"), prefixText: "\Rp. ", suffixText: ', 00-'),
    );
  }
}
