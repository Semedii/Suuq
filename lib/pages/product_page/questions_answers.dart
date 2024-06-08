import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq/utils/app_colors.dart';
import 'package:suuq/utils/app_styles.dart';

@RoutePage()
class QuestionAnswersPage extends StatelessWidget {
  const QuestionAnswersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Questions and Answers"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppStyles.edgeInsetsV24,
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
              children: [Icon(Icons.abc), Text("PixelBazaar", style: TextStyle(fontWeight: FontWeight.bold),)],
            ),
            Text(
                "Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed. Fadlan qiimahu waa fixed.")
          ],
        ),
      ),
    );
  }
}
