import 'package:flutter/material.dart';
import '../pages/add_book.dart';

class ReaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> filters;
  final String selected;
  final Function(String) onFilterSelected;

  const ReaderAppBar({
    super.key,
    required this.filters,
    required this.selected,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("E-Reader"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => print("Search"),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true, // tap outside to close
              builder: (context) => const AddBookDialog(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => print("Settings"),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: filters.map((filter) {
              return ChoiceChip(
                label: Text(filter),
                shape: const StadiumBorder(),
                selected: filter == selected,
                onSelected: (_) => onFilterSelected(filter),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
