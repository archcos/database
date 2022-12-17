import 'package:flutter/material.dart';
import 'database.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {

  final TextEditingController idController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController completedController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List comChoice = ["", "true", "false"];
  String selectedChoice = '';
  List<DataModel> todos = [];
  bool fetching = true;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add To Do"),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                TextFormField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Unique ID',
                      hintText: 'Unique ID'
                  ),
                  validator: (value){
                    return (value == '')? "Input a Unique ID" : null;
                  },
                ),
                TextFormField(
                  controller: userIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'User ID',
                      hintText: 'User ID'
                  ),
                  validator: (value){
                    return (value == '')? "Input User ID" : null;
                  },
                ),
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Title'
                  ),
                  validator: (value){
                    return (value == '')? "Input Title" : null;
                  },
                ),
                DropdownButtonFormField(
                    value: selectedChoice,
                    decoration: const InputDecoration(
                      labelText: 'Completed',
                    ),
                    validator: (value){
                      return (value == '')? "Choose Progress" : null;
                    },
                    items: [
                      ...comChoice.map((choices) => DropdownMenuItem(
                          value: choices,
                          child: Text(choices)))
                    ],
                    onChanged: (value){
                      setState(() {
                        selectedChoice = value as String;
                      }
                      );
                      completedController.text = selectedChoice;
                    }
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DataModel dataLocal = DataModel(
                            // id: todos[todos.length - 1].id! + 1,
                            id: int.parse(idController.text),
                            userId: int.parse(userIdController.text),
                            title: titleController.text,
                            completed: completedController.text);
                        // dataLocal.id = todos[todos.length - 1].id! + 1;
                        const snackBar = SnackBar(
                            content: Text('Created Successfully')
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                        });
                        Navigator.pop(context, dataLocal);
                      }
                    },
                    child: const Text('Add To Do')
                ),
            ],
        )
      ),
    );
  }
}
