//C:\dev\task_manager\lib\screens\task\task_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/task.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user!;
    final taskProvider = context.read<TaskProvider>();

    return StreamBuilder<List<Task>>(
      stream: taskProvider.taskStream(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucune tâche'));
        }

        final tasks = snapshot.data!;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return ListTile(
              title: Hero(
                tag: task.id,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    task.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              subtitle: Text(task.description),
              trailing: Checkbox(
                value: task.isDone,
                onChanged: (_) {
                  taskProvider.updateTask(
                    Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      isDone: !task.isDone,
                      userId: task.userId,
                      createdAt: task.createdAt,
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskDetailScreen(taskId: task.id),
                  ),
                );
              },
              onLongPress: () {
                taskProvider.deleteTask(task.id);
              },
            );
          },
        );
      },
    );
  }
}
