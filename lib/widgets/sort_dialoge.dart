import 'package:flutter/material.dart';

class SortDialog extends StatelessWidget {
  final void Function(String) onSortSelected;

  const SortDialog({super.key, required this.onSortSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Sort By',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Price - High to Low'),
            onTap: () {
              Navigator.of(context).pop();
              onSortSelected('highToLow');
            },
          ),
          ListTile(
            title: const Text('Price - Low to High'),
            onTap: () {
              Navigator.of(context).pop();
              onSortSelected('lowToHigh');
            },
          ),
          ListTile(
            title: const Text('Rating'),
            onTap: () {
              Navigator.of(context).pop();
              onSortSelected('rating');
            },
          ),
        ],
      ),
    );
  }
}
