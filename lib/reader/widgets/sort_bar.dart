import 'package:flutter/material.dart';

class SortBar extends StatefulWidget {
  const SortBar({super.key});

  @override
  State<SortBar> createState() => _SortBarState();
}

class _SortBarState extends State<SortBar> {
  String selectedSort = "Last read";

  final List<String> options = ["Last read", "Date added", "Title", "Progress"];

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option),
              trailing: option == selectedSort ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => selectedSort = option);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Your books",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: _showSortSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.sort, size: 18),
                  const SizedBox(width: 6),
                  Text(selectedSort),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
