import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite_todo_app/widget/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/crud_bloc.dart';
import '../model/todo.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo;
  const AddTodoPage({Key? key, this.todo}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  bool toggleSwitch = false;

  @override
  void initState() {
    super.initState();
    toggleSwitch = widget.todo?.isImportant ?? false;
    _title.text = widget.todo?.title ?? "";
    _description.text = widget.todo?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                CustomText(text: "Title".toUpperCase()),
                TextFormField(
                  controller: _title,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [
                CustomText(text: "Description".toUpperCase()),
                TextFormField(
                  controller: _description,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [
                CustomText(text: "Important".toUpperCase()),
                Switch(
                  value: toggleSwitch,
                  onChanged: (newVal) {
                    setState(() {
                      toggleSwitch = !toggleSwitch;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            BlocBuilder<CrudBloc, CrudState>(builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (_title.text.isNotEmpty && _description.text.isNotEmpty) {
                    if (widget.todo == null) {
                      context.read<CrudBloc>().add(
                        AddTodo(
                          title: _title.text,
                          isImportant: toggleSwitch,
                          number: 0,
                          description: _description.text,
                          createdTime: DateTime.now(),
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Todo added successfully"),
                            duration: Duration(seconds: 1),
                          )
                      );

                      context.read<CrudBloc>().add(const FetchTodos());
                      Navigator.pop(context);
                      return;
                    } else { // Update
                      Todo todo = Todo(
                          id: widget.todo!.id,
                          isImportant: toggleSwitch, 
                          number: 0, 
                          title: _title.text, 
                          description: _description.text, 
                          createdTime: DateTime.now()
                      );

                      context.read<CrudBloc>().add(UpdateTodo(todo: todo),);

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Todo updated successfully"),
                            duration: Duration(seconds: 2),
                          )
                      );

                      context.read<CrudBloc>().add(const FetchTodos());
                      Navigator.popUntil(context, (route) => route.isFirst);
                      return;
                    }
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Title and description fields must not be blank"),
                        duration: Duration(seconds: 1),
                      )
                  );

                },
                child: widget.todo != null ? const Text( "Update") : const Text("Add Todo"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
