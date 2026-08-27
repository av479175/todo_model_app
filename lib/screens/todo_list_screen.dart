import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';


class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final todos = ref.watch(todoProvider); // was context.watch<TodoProvider>().todos

    return Scaffold(
      appBar: AppBar(title: Text("My Todos")),
      body: todos.isEmpty
          ? const Center(child: Text('No todos yet — tap + to add one'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Dismissible(
                  key: ValueKey(todo.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Theme.of(context).colorScheme.errorContainer,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (_) => {
                    ref.read(todoProvider.notifier).deleteTodo(todo.id),
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) => {
                        ref.read(todoProvider.notifier).toggleTodo(todo.id),
                      },
                    ),
                    title: Text(
                      todo.title,
                      overflow: TextOverflow.ellipsis,
                      style: todo.isDone
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                    onTap: () => context.go('/edit/${todo.id}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/edit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
