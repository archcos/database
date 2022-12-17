import 'package:flutter/material.dart';
import 'database.dart';
import 'update_todo_page.dart';
import 'add_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DataModel> todos = [];
  bool fetching = true;
  final db = NewDatabase();

  @override
  void initState() {
    super.initState();
    db.initDB();
    getData2();
  }

  void getData2() async {
    todos = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  deleteTodo(int id) {
    todos.removeWhere((item) => item.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do'),
        ),
        body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                color: Colors.redAccent,
                ),
                onDismissed: (DismissDirection direction){
                  final snackBar = SnackBar(
                    content: Text('ID: ${todos[index].id} Deleted Successfully')
                    );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  int idNum = todos[index].id;
                  setState(() {
                    deleteTodo(idNum);
                    db.delete(idNum);
                    });
                },
                key: UniqueKey(),
                child: ExpansionTile(
                  title:Text('ID: ${todos[index].id}'),
                  subtitle: Text('User ID: ${todos[index].userId}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async{
                            var update = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateTodo(data: todos[index])
                                )
                            );
                            if (update == true){
                              setState(() {
                              });
                            }
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                  children: [
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.all(15)),
                        Text('Title: ${todos[index].title}')
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.all(15)),
                        Text('Completed: ${todos[index].completed}')
                      ],
                    )
                  ],
                )
              );
            }
         ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            var postTodo = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTodo()
                )
              );
            if (postTodo!=null){
              setState(() {
                todos.add(postTodo);
                db.insertData(postTodo);
              });
            }
          },
          child: const Icon(Icons.add),
      ),
    );
  }
}