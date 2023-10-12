import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite_todo_app/bloc/crud_bloc.dart';
import 'package:flutter_bloc_sqlite_todo_app/page/add_todo.dart';
import 'package:flutter_bloc_sqlite_todo_app/page/details_page.dart';
import 'package:flutter_bloc_sqlite_todo_app/page/splash_screen.dart';
import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => CrudBloc())],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        )
    );
  }
}

class BlocSqlDemo extends StatefulWidget {
  const BlocSqlDemo({Key? key}) : super(key: key);

  @override
  State<BlocSqlDemo> createState() => _BlocSqlDemoState();
}

class _BlocSqlDemoState extends State<BlocSqlDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bloc + Sqlite"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black54,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTodoPage()));
        },
      ),
      body: BlocBuilder<CrudBloc, CrudState>(builder: (context, state) {
        if (state is CrudInitial) {
          context.read<CrudBloc>().add(const FetchTodos());
        }
        if (state is DisplayTodos) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Add a Todo".toUpperCase(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  state.todos.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: state.todos.length,
                      itemBuilder: (context, i) {
                        Todo todo = state.todos[i];
                        return Card(
                          elevation: 5,
                          color: Colors.green,
                          margin: const EdgeInsets.only(bottom: 14),
                          child: ListTile(
                            title: Text(todo.title),
                            subtitle: Text(todo.description),
                            onTap: () {
                              context.read<CrudBloc>().add(FetchSpecificTodo(id: todo.id!));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsPage()));
                            },
                            trailing: IconButton(
                              onPressed: () {
                                context.read<CrudBloc>().add(DeleteTodo(id: todo.id!));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : const Center(child: Text("Todo Empty")),
                ],
              ),
            ),
          );
        }
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
