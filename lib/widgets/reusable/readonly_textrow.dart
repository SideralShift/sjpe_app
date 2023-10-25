import 'package:flutter/material.dart';

class ReadOnlyTextRow extends StatelessWidget {
  String label;
  String? text;

  ReadOnlyTextRow({required this.label, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            text ?? '',
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          )
        ],
      ),
    );
  }
  
}