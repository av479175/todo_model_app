
class Todo {
  final String id;
  final String title;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  // Returns a NEW Todo with updated fields — never mutate the original.
  // This immutable-copy pattern is standard across Flutter state management.
  //you keep the original model immutable but whenever you want a change you create a object copy of it.
  Todo copyWith({String? title, bool? isDone}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}