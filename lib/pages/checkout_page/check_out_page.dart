import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/notifiers/checkout/checkout_notifier.dart';
import 'package:suuq/notifiers/checkout/checkout_state.dart';
import 'package:suuq/pages/checkout_page/confirmation_step.dart';
import 'package:suuq/pages/checkout_page/payment_step.dart';
import 'package:suuq/utils/app_colors.dart';

@RoutePage()
class CheckOutPage extends ConsumerWidget {
  final double totalAmount;
  const CheckOutPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
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
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _checkouSteppers(
    BuildContext context,
    CheckoutLoadedState state,
    WidgetRef ref,
  ) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.green,
        )
      ),
      child: Stepper(
        onStepTapped: ref.read(checkoutNotifierProvider.notifier).onStepTapped,
        currentStep: state.stepIndex,
        controlsBuilder: (context, details) {
          return const SizedBox.shrink();
        },
        type: StepperType.horizontal,
        steps: [
          Step(
            title: const Text("Payment"),
            content: PaymentStep(totalAmount: totalAmount),
            isActive: state.stepIndex == 0,
            state: state.stepIndex > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
              title: const Text("Confirmaion"),
              content: const ConfirmationStep(),
              isActive: state.stepIndex == 1,
              state: StepState.indexed),
        ],
      ),
    );
  }
}
