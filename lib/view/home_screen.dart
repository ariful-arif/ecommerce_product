import 'package:ecommerce_product/Controller/product_controller.dart';
import 'package:ecommerce_product/constants/colors.dart';
import 'package:ecommerce_product/widgets/product_grid.dart';
import 'package:ecommerce_product/widgets/sort_dialoge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isShowing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !ref.read(productControllerProvider.notifier).isLoadingMore) {
        ref.read(productControllerProvider.notifier).fetchMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productControllerProvider);
    final isLoadingMore =
        ref.watch(productControllerProvider.notifier).isLoadingMore;
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    // final height = screenSize.height;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 19.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 48,
                        width: width - 80,
                        child: CupertinoSearchTextField(
                          onChanged: (value) {
                            ref
                                .read(productControllerProvider.notifier)
                                .setSearchQuery(value);
                            setState(() {
                              _isShowing = value.isNotEmpty;
                            });
                          },

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
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            color: blackTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            // shape: const RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.vertical(
                            //     top: Radius.circular(16),
                            //   ),
                            // ),
                            builder: (context) {
                              return SortDialog(
                                onSortSelected: (sortType) {
                                  ref
                                      .read(productControllerProvider.notifier)
                                      .sortProducts(sortType);
                                  setState(() {
                                    _isShowing = true;
                                  });
                                },
                              );
                            },
                          );
                        },

                        child: SvgPicture.asset(
                          'assets/icons/sort.svg',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isShowing)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 34,
                    width: width,
                    decoration: BoxDecoration(
                      color: barCOlor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      '${ref.watch(productControllerProvider).value?.length ?? 0} Items',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: blackTextColor,
                      ),
                    ),
                  ),
                ),

              if (_isShowing) const SizedBox(height: 20),
              const SizedBox(height: 20),
              Expanded(
                child: productsAsync.when(
                  data:
                      (products) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                controller: _scrollController,
                                itemCount: products.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 24,
                                      childAspectRatio: 0.6,
                                    ),
                                itemBuilder: (context, index) {
                                  return Product(product: products[index]);
                                },
                              ),
                            ),
                            if (isLoadingMore)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
