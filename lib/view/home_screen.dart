import 'package:ecommerce_product/constants/colors.dart';
import 'package:ecommerce_product/widgets/product_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 19.0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                width: width,
                child: CupertinoSearchTextField(
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search-normal.svg',
                    height: 24,
                    width: 24,
                  ),
                  placeholder: 'Search Anything...',
                  placeholderStyle: const TextStyle(
                    color: greyTextColor,
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: searchBorder, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Product(width: width),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
