import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData actionIcon;
  final VoidCallback onActionPressed;

  const DetailSection({
    super.key,
    required this.title,
    required this.content,
    required this.actionIcon,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final items = content
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final bool isList = items.length > 1;
    final bool isEmpty = items.isEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(actionIcon, size: 20),
                onPressed: onActionPressed,
              ),
            ],
          ),

          /// Content
          if (isEmpty)
            _EmptyState(title: title)
          else if (isList)
            Column(
              children: items.map((item) => _CapsuleItem(text: item)).toList(),
            )
          else
            _SingleBlock(text: items.first),
        ],
      ),
    );
  }
}

class _CapsuleItem extends StatelessWidget {
  final String text;

  const _CapsuleItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30), // cylindrical
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class _SingleBlock extends StatelessWidget {
  final String text;

  const _SingleBlock({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;

  const _EmptyState({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "No $title yet",
        style: TextStyle(
          color: Colors.grey.shade500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
