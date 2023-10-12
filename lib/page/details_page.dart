import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite_todo_app/bloc/crud_bloc.dart';
import 'package:flutter_bloc_sqlite_todo_app/model/todo.dart';
import 'package:flutter_bloc_sqlite_todo_app/page/add_todo.dart';
import 'package:flutter_bloc_sqlite_todo_app/widget/custom_text.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Details Page"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<CrudBloc>().add(const FetchTodos());
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<CrudBloc, CrudState>(builder: (context, state) {
          if (state is DisplaySpecificTodo) {
            Todo todo = state.todo;
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Column(
                    children: [
                      CustomText(text: "Title".toUpperCase()),
                      TextFormField(
                        initialValue: todo.title,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(text: "Desciption".toUpperCase()),
                      TextFormField(
                        initialValue: todo.description,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(text: "Date Made".toUpperCase()),
                      CustomText(
                        text: DateFormat.yMMMEd().format(todo.createdTime),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText(text: "Important/not important".toUpperCase()),
                      CustomText(
                        text: todo.isImportant
                            ? "Important".toUpperCase()
                            : "not important".toUpperCase(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoPage(todo: todo,)));
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            );
          }
          return Container();
        }));
  }
}
