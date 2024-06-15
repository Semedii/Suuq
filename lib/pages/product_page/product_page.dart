import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/notifiers/home/home_notifier.dart';
import 'package:suuq/router/app_router.gr.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class ProductPage extends StatefulWidget {
  const ProductPage(this.product, {super.key});

  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    bool isImageAvailable = widget.product.imageUrl.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
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
                        buildCarousel(context, isImageAvailable),
                        _buildSellerAndProductName(),
                        _builFeatures(),
                        if (widget.product.extraDescription != null)
                          _buildExtraDescription(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align _buildQuestionAnswersButton(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
            onPressed: () => AutoRouter.of(context)
                .push(ProductQuestionsRoute(product: widget.product)),
            child: Text(
              "Suaalo iyo jawaabo (${widget.product.questions.length})",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            )));
  }

  Widget _buildBottomBar() {
    return Consumer(builder: (context, ref, _) {
      AppLocalizations localizations = AppLocalizations.of(context)!;
      return Container(
        height: MediaQuery.of(context).size.height * .15,
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 4),
        color: AppColors.white,
        child: Column(
          children: [
            _buildPrice(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  localizations.buyNow,
                  onTap: () => AutoRouter.of(context).push(CheckOutRoute(
                      totalAmount: widget.product.price,
                      cartProductList: [
                        CartProduct.mapProductToCartProduct(
                            product: widget.product)
                      ])),
                ),
                _buildButton(localizations.addToCart, isTransparent: true,
                    onTap: () {
                  ref
                      .read(homeNotifierProvider.notifier)
                      .addToCart(widget.product, localizations);
                }),
              ],
            ),
          ],
        ),
      );
    });
  }

  int _current = 0;
  Widget buildCarousel(BuildContext context, bool isImageAvailable) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            CarouselSlider(
              options: _buildCarouselOptions(context),
              items: widget.product.imageUrl.map((url) {
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
            if (widget.product.imageUrl.length > 1) _buildDotIndicator()
          ],
        ),
        IconButton(
          padding: AppStyles.edgeInsetsH20,
          onPressed: (){}, icon: Icon(Icons.favorite_outline, color: Colors.red, size: 40,))
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

  DotsIndicator _buildDotIndicator() {
    return DotsIndicator(
      dotsCount: widget.product.imageUrl.length,
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

  Padding _buildSellerAndProductName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.product.sellerName,
              style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              recognizer: TapGestureRecognizer()
                ..onTap = () => AutoRouter.of(context).push(StoreRoute(
                      sellerEmail: widget.product.sellerEmail,
                      storename: widget.product.sellerName,
                    )),
            ),
            TextSpan(
              text: ' - ${widget.product.description}',
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

  Widget _builFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        children: widget.product.features!
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

  _buildExtraDescription() {
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
          Text(widget.product.extraDescription ?? ""),
        ],
      ),
    );
  }

  Text _buildPrice() {
    return Text(
      '${widget.product.price.toStringAsFixed(2)}\$',
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
}
