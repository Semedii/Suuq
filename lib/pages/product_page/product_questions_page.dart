import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:suuq/components/app_button.dart';
import 'package:suuq/models/product.dart';
import 'package:suuq/models/product_questions.dart';
import 'package:suuq/notifiers/questionsAnswers/product_questions_notifier.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class ProductQuestionsPage extends ConsumerWidget {
  ProductQuestionsPage({required this.product, super.key});
  final TextEditingController questionController = TextEditingController();

  final Product product;

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
                  children: product.questions
                      .map((question) => _buildQuestionAndAnswer(question!))
                      .toList()),
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

  Card _buildQuestionAndAnswer(ProductQuestions questions) {
    return Card(
      color: AppColors.lightestGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildQuestion(questions), _buildAnswer(questions)],
      ),
    );
  }

  Widget _buildQuestion(ProductQuestions questions) {
    return Padding(
      padding: AppStyles.edgeInsets4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questions.question,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Asked by: ${questions.askedName}',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          Text(
            'Date: ${DateFormat('yyyy-MM-dd').format(questions.dateTime)}',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Card _buildAnswer(ProductQuestions questions) {
    return Card(
      child: Padding(
        padding: AppStyles.edgeInsetsl16,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.abc),
                Text(
                  product.sellerName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(questions.answer)
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
                        .addNewQuestion(product.id, questionController.text);
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
