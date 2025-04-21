import 'package:ecommerce_product/Models/product_model.dart';
import 'package:ecommerce_product/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Product extends StatefulWidget {
  final ProductModel product;
  const Product({super.key, required this.product});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool _isFavourite = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return SizedBox(
      // height: 164,
      // width: width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 164,
                width: width / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFavourite = !_isFavourite;
                    });
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: scaffoldBg,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SvgPicture.asset(
                      _isFavourite
                          ? 'assets/icons/heart_fill.svg'
                          : 'assets/icons/heart.svg',
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.product.title ?? 'No Title',
              maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Current Price
              Text(
                '\$${widget.product.price?.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(width: 4),

              // Original Price
              Text(
                '\$${widget.product.price?.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: "Inter",
                  color: greyTextColor,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 4),
              // Discount
              const Text(
                '15% OFF',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "Inter",
                  color: redTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 16,
                width: 16,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: yelloStarBoxColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: SvgPicture.asset(
                  'assets/icons/star.svg',
                  height: 12,
                  width: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.product.rating?.rate ?? 0.0}',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: blackTextColor,
                ),
              ),
              const SizedBox(width: 4),

              Text(
                '(${widget.product.rating?.count ?? 0})',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Inter",
                  color: greyDarkBoxColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
