import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/app_bar.dart';
import '../../../../../core/components/product_item_widget.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../favorite/presentation/manager/favourite_cubit.dart';
import '../../../home/domain/home_entity/home_entity.dart';
import '../../suggested_products_args.dart';

class SuggestedProductsScreen extends StatefulWidget {
  const SuggestedProductsScreen({
    super.key,
    required this.args,
  });

  final SuggestedProductsArgs args;

  @override
  State<SuggestedProductsScreen> createState() =>
      _SuggestedProductsScreenState();
}

class _SuggestedProductsScreenState extends State<SuggestedProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _productsPerPage = 8;
  final double _scrollThreshold = 100.0;
  List<ProductEntity> _displayedProducts = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _initializeProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeProducts() {
    setState(() {
      _displayedProducts = widget.args.products.take(_productsPerPage).toList();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - _scrollThreshold &&
        !_isLoading &&
        _hasMore) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    if (!_hasMore) return;
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      final int start = _currentPage * _productsPerPage;
      final int end = start + _productsPerPage;
      if (start >= widget.args.products.length) {
        _hasMore = false;
      } else {
        _currentPage++;
        _displayedProducts.addAll(
          widget.args.products
              .sublist(start, end.clamp(0, widget.args.products.length)),
        );
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();
    safePrint("Products received: ${widget.args.products.length}"); // Debug log

    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(
            text: S().suggestedForYou,
            cartIcon: false,
            backArrow: true,
          ),
          if (widget.args.products.isEmpty)
            const Center(
                child: Text(
                    "No products available.")),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.sp,
                crossAxisSpacing: 10.sp,
                childAspectRatio: 0.62.sp,
              ),
              itemCount: _displayedProducts.length,
              itemBuilder: (context, index) {
                final product = _displayedProducts[index];
                return ProductItemWidget(
                  price: product.price.toString(),
                  name: product.name,
                  image: product.image,
                  id: product.id,
                  inFavorites: product.isFav,
                  oldPrice: product.oldPrice.toString(),
                  discount: product.discount.toString(),
                  favoriteCubit: favouriteCubit,
                );
              },
            ),
          ),
          if (_isLoading && _hasMore)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}
