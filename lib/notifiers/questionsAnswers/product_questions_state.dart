import 'package:suuq/models/product_questions.dart';

class ProductQuestionsState {}

class ProductQuestionsInitialState extends ProductQuestionsState{}

class ProductQuestionsLoadingState extends ProductQuestionsState{}

class ProductQuestionsLoadedState extends ProductQuestionsState{
  final List<ProductQuestions> productQuestions;

  ProductQuestionsLoadedState({required this.productQuestions});
}
