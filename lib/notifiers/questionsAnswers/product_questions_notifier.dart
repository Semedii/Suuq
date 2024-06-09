import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq/models/product_questions.dart';
import 'package:suuq/notifiers/questionsAnswers/product_questions_state.dart';
import 'package:suuq/services/auth_data_service.dart';
import 'package:suuq/services/product_data_service.dart';

class ProductQuestionsNotifier extends StateNotifier<ProductQuestionsState> {
  final AuthDataService _authDataService = AuthDataService();
  final ProductDataService _productDataService = ProductDataService();
  ProductQuestionsNotifier() : super(ProductQuestionsInitialState());

  initPage() async {}

  addNewQuestion(String? productId, String question) async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final user = await _authDataService.fetchCurrentUser(userEmail!);

    final ProductQuestions newQuestion = ProductQuestions(
      question: question,
      answer: '',
      askedName: user!.name!,
      dateTime: DateTime.now(),
    );
   await _productDataService.addNewQuestion(productId: productId!, question: newQuestion);
  }
}

final productQuestionsNotifierProvider =
    StateNotifierProvider<ProductQuestionsNotifier, ProductQuestionsState>(
  (ref) => ProductQuestionsNotifier(),
);
