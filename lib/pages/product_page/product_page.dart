import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/notifiers/product/product_notifier.dart';
import 'package:suuq/notifiers/product/product_state.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class ProductPage extends ConsumerStatefulWidget {
  ProductPage({required this.productId, super.key});
  final String productId;

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends ConsumerState<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productNotifierProvider);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _mapStateToWidget(context, state, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => AutoRouter.of(context).push(const CartRoute()),
          icon: const Icon(Icons.shopping_cart),
        ),
        IconButton(
          onPressed: () => throw UnimplementedError(),
          icon: const Icon(Icons.share_sharp),
        ),
      ],
    );
  }

  Widget _mapStateToWidget(
      BuildContext context, ProductState state, WidgetRef ref) {
    if (state is ProductInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productNotifierProvider.notifier).initPage(widget.productId);
      });
    } else if (state is ProductLoadedState) {
      return _buildPageBody(context, state, ref);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Column _buildPageBody(
      BuildContext context, ProductLoadedState state, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCarousel(context, state.product, ref),
                      _buildSellerAndProductName(context, state.product),
                      _builFeatures(state.product),
                      if (state.product.extraDescription != null)
                        _buildExtraDescription(state.product),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomBar(context, state.product, ref)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, Product product, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.of(context).size.height * .15,
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 4),
      color: AppColors.white,
      child: Column(
        children: [
          _buildPrice(product),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton(
                localizations.buyNow,
                onTap: () => AutoRouter.of(context).push(CheckOutRoute(
                    totalAmount: product.price,
                    cartProductList: [
                      CartProduct.mapProductToCartProduct(product: product)
                    ])),
              ),
              _buildButton(localizations.addToCart, isTransparent: true,
                  onTap: () {
                ref
                    .read(homeNotifierProvider.notifier)
                    .addToCart(product, localizations);
              }),
            ],
          ),
        ],
      ),
    );
  }

  int _current = 0;
  Widget buildCarousel(BuildContext context, Product product, WidgetRef ref) {
    bool isImageAvailable = product.imageUrl.isNotEmpty;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            CarouselSlider(
              options: _buildCarouselOptions(context),
              items: product.imageUrl.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: isImageAvailable
                          ? InkWell(
                              onTap: () => AutoRouter.of(context)
                                  .push(FullPhotoRoute(imageUrl: url)),
                              child: Image.network(
                                url!,
                                fit: BoxFit.contain,
                                loadingBuilder: _imageNetworkLoadingBuilder,
                              ),
                            )
                          : Image.asset(
                              "assets/images/noImageAvailable.jpeg",
                              height: 200,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                    );
                  },
                );
              }).toList(),
            ),
            if (product.imageUrl.length > 1) _buildDotIndicator(product)
          ],
        ),
        IconButton(
            padding: AppStyles.edgeInsetsH20,
            onPressed:
                ref.read(productNotifierProvider.notifier).onFavButtonPressed,
            icon: Icon(
              product.isFav ? Icons.favorite : Icons.favorite_outline,
              color: Colors.red,
              size: 40,
            ))
      ],
    );
  }

  CarouselOptions _buildCarouselOptions(BuildContext context) {
    return CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.6,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index, reason) {
        setState(() {
          _current = index;
        });
      },
    );
  }

  DotsIndicator _buildDotIndicator(Product product) {
    return DotsIndicator(
      dotsCount: product.imageUrl.length,
      position: _current,
      decorator: DotsDecorator(
        shape: const Border(),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        size: const Size.square(10),
        activeSize: const Size(20, 10),
      ),
    );
  }

  Padding _buildSellerAndProductName(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: product.sellerName,
              style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              recognizer: TapGestureRecognizer()
                ..onTap = () => AutoRouter.of(context).push(StoreRoute(
                      sellerEmail: product.sellerEmail,
                      storename: product.sellerName,
                    )),
            ),
            TextSpan(
              text: ' - ${product.description}',
              style: const TextStyle(color: AppColors.black, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildStarRating(3),
          const SizedBox(width: 8),
          _buildReviewsText(),
        ],
      ),
    );
  }

  Text _buildReviewsText() {
    return const Text(
      '${3.9}/5 (${190} reviews)',
      style: TextStyle(
        color: AppColors.black,
        fontSize: 16,
      ),
    );
  }

  Widget _builFeatures(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        children: product.features!
            .where((feature) => feature != null)
            .map((feature) => _buildFeaureItem(feature!.title, feature.value))
            .toList(),
      ),
    );
  }

  Container _buildFeaureItem(String title, String detail) {
    return Container(
      padding: AppStyles.edgeInsets4,
      margin: AppStyles.edgeInsets4,
      color: AppColors.green.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColors.green, fontWeight: FontWeight.bold),
          ),
          Text(detail)
        ],
      ),
    );
  }

  _buildExtraDescription(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyles.edgeInsets4,
            child: Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(product.extraDescription ?? ""),
        ],
      ),
    );
  }

  Text _buildPrice(Product product) {
    return Text(
      '${product.price.toStringAsFixed(2)}\$',
      style: const TextStyle(
        color: AppColors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          color: const Color.fromARGB(255, 151, 121, 3),
        ),
      ),
    );
  }

  Widget _buildButton(String title,
      {bool isTransparent = false, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isTransparent ? null : Colors.green,
          border: isTransparent ? Border.all() : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isTransparent ? Colors.black : Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _imageNetworkLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child;
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
  }

  Align _buildQuestionAnswersButton(BuildContext context, Product product) {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
            onPressed: () => AutoRouter.of(context)
                .push(ProductQuestionsRoute(product: product)),
            child: Text(
              "Suaalo iyo jawaabo (${product.questions.length})",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            )));
  }
}
