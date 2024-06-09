import 'package:cloud_firestore/cloud_firestore.dart';

class ProductQuestions {
  final String question;
  final String answer;
  final String askedName;
  final DateTime dateTime;

  ProductQuestions({required this.question, required this.answer, required this.askedName, required this.dateTime});

  factory ProductQuestions.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductQuestions(
      question: data?['question'] ?? '',
      answer: data?['answer'] ?? '',
      askedName: data?['askedName'] ?? '',
      dateTime: (data?['dateTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "question": question,
      "answer": answer,
      "askedName": askedName,
      "dateTime": dateTime,
    };
  }
}
