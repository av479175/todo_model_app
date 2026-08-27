// screens/todo_edit_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';

class TodoEditScreen extends ConsumerStatefulWidget { // was StatefulWidget
  final String? todoId;
  const TodoEditScreen({super.key, this.todoId});

  @override
  ConsumerState<TodoEditScreen> createState() => _TodoEditScreenState(); // was State<TodoEditScreen>
}

class _TodoEditScreenState extends ConsumerState<TodoEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;

  bool get isEditing => widget.todoId != null;
  @override
  void initState() {
    super.initState();
    final existing = isEditing
        ? ref.read(todoProvider.notifier).getById(widget.todoId!)
        : null;
    _titleController = TextEditingController(text: existing?.title ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose(); // always dispose controllers — real memory leak otherwise
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(todoProvider.notifier); // was context.read<TodoProvider>()
    if (isEditing) {
      notifier.editTodo(widget.todoId!, _titleController.text.trim());
    } else {
      notifier.addTodo(_titleController.text.trim());
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Todo' : 'Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),ElevatedButton(
                onPressed: (){
                  //ACTION TO BACK
                  context.go('/');
                },
                child: const Text('home screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}