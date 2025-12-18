import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final String userId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.userId,
    required this.createdAt,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      isDone: data['isDone'],
      userId: data['userId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
