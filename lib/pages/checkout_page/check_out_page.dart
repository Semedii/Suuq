import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/cart_product.dart';
import 'package:suuq/notifiers/checkout/checkout_notifier.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/pages/checkout_page/confirmation_page.dart';
import 'package:suuq/pages/checkout_page/order_failure_page.dart';
import 'package:suuq/pages/checkout_page/sending_step.dart';
import 'package:suuq/pages/checkout_page/payment_step.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class CheckOutPage extends ConsumerWidget {
  final List<CartProduct?> cartProductList;
  final double totalAmount;
  const CheckOutPage({
    super.key,
    required this.cartProductList,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.checkout),
      ),
      body: _mapStateToWidget(context, checkoutState, ref),
    );
  }

  Widget _mapStateToWidget(
    BuildContext context,
    CheckoutState state,
    WidgetRef ref,
  ) {
    if (state is CheckoutInitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(checkoutNotifierProvider.notifier).initPage();
      });
    } else if (state is CheckoutLoadedState) {
      return _checkouSteppers(context, state, ref);
    } else if (state is CheckoutFailureState) {
      return OrderFailurePage(contactNumber:  state.contactNumber);
    } else if (state is CheckoutSuccessState) {
      return const ConfirmationPage();
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _checkouSteppers(
    BuildContext context,
    CheckoutLoadedState state,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Theme(
      data: ThemeData(
          colorScheme: const ColorScheme.light(
        primary: AppColors.green,
      )),
      child: Stepper(
        onStepTapped: ref.read(checkoutNotifierProvider.notifier).onStepTapped,
        currentStep: state.stepIndex,
        controlsBuilder: (context, details) {
          return const SizedBox.shrink();
        },
        type: StepperType.horizontal,
        steps: [
          Step(
            title: Text(localizations.paymentMethod),
            content: PaymentStep(totalAmount: totalAmount),
            isActive: state.stepIndex == 0,
            state: state.stepIndex > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
              title: Text(localizations.sending),
              content: SendingStep(
                onPaymentSent: () => ref
                    .read(checkoutNotifierProvider.notifier)
                    .onPaymentSent(cartProductList, totalAmount),
              ),
              isActive: state.stepIndex == 1)
        ],
      ),
    );
  }
}
