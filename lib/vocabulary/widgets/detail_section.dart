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
    final bool isEmpty = content.trim().isEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: isEmpty
                ? Text(
                    "No $title yet",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : Text(content),
          ),
        ],
      ),
    );
  }
}
