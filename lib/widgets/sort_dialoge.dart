import 'package:ecommerce_product/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    color: blackTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              InkWell(
                child: SvgPicture.asset(
                  "assets/icons/x.svg",
                  height: 24,
                  width: 24,
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0.0,
            title: const Text(
              'Price - High to Low',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Inter",
                color: blackTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onSortSelected('highToLow');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0.0,
            title: const Text(
              'Price - Low to High',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Inter",
                color: blackTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onSortSelected('lowToHigh');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0.0,
            title: const Text(
              'Rating',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Inter",
                color: blackTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
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
