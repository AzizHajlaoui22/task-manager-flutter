//C:\dev\task_manager\lib\screens\task\task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/task.dart';
import 'edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .snapshots(),
      builder: (context, snapshot) {
        // 🔄 Chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ Tâche inexistante (supprimée ou erreur)
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('Tâche introuvable')),
          );
        }

        // ✅ Données valides
        final task = Task.fromFirestore(snapshot.data!);

        return Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: task.id,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  task.description,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 20),

                // Statut
                Text(
                  task.isDone ? 'Statut : Terminée' : 'Statut : En cours',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: task.isDone ? Colors.green : Colors.orange,
                  ),
                ),

                const SizedBox(height: 20),

                // Date de création
                Text(
                  'Créée le : ${task.createdAt.toLocal()}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // Bouton Modifier
                ElevatedButton(
                  child: const Text('Modifier'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTaskScreen(task: task),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Bouton Supprimer
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Supprimer'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                          'Voulez-vous supprimer cette tâche ?',
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Annuler'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text('Supprimer'),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(task.id)
                                  .delete();

                              Navigator.pop(context); // ferme le dialog
                              Navigator.pop(context); // retour à la liste
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
