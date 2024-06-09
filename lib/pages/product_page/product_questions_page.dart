import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/notifiers/questionsAnswers/product_questions_notifier.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class ProductQuestionsPage extends ConsumerWidget {
  ProductQuestionsPage({this.productId, super.key});
  final TextEditingController questionController = TextEditingController();

  final String? productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Questions and Answers"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: AppStyles.edgeInsetsV24 + AppStyles.edgeInsetsB48,
              child: Column(
                children: [
                  _buildQuestionAndAnswer(),
                  _buildQuestionAndAnswer(),
                  _buildQuestionAndAnswer(),
                  _buildQuestionAndAnswer(),
                  _buildQuestionAndAnswer(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            child: AppButton(
                title: "Ask new question",
                onTap: () {
                  _onAskNewQuestion(context, ref);
                }),
          )
        ],
      ),
    );
  }

  Card _buildQuestionAndAnswer() {
    return Card(
      color: AppColors.lightestGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildQuestion(), _buildAnswer()],
      ),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: AppStyles.edgeInsets4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Discount ma la samayn karaa?"),
          Text("A**** I**** Y***"),
          Text("24/06/2023"),
        ],
      ),
    );
  }

  Card _buildAnswer() {
    return Card(
      child: Padding(
        padding: AppStyles.edgeInsetsl16,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.abc),
                Text(
                  "PixelBazaar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(
                "Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed.")
          ],
        ),
      ),
    );
  }

  void _onAskNewQuestion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: questionController,
                decoration: const InputDecoration(hintText: "Question"),
              ),
              TextButton(
                  onPressed: () {
                    ref
                        .read(productQuestionsNotifierProvider.notifier)
                        .addNewQuestion(productId, questionController.text);
                    Navigator.pop(context);
                  },
                  child: Text("ASK")),
              TextButton(onPressed: () {}, child: Text("Cancel")),
            ],
          ),
        );
      },
    );
  }
}
