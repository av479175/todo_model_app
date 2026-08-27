// router/app_router.dart
import 'package:go_router/go_router.dart';
import '../screens/todo_list_screen.dart';
import '../screens/todo_edit_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TodoListScreen(), //inital screen
    ),
    GoRoute(
      path: '/edit',
      builder: (context, state) => const TodoEditScreen(), // add mode, no id
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TodoEditScreen(todoId: id); // edit mode
      },
    ),
  ],
);