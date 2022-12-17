import 'package:flutter/material.dart';
import 'database.dart';

class UpdateTodo extends StatefulWidget {

  final DataModel data;

  const UpdateTodo({
    required this.data,
    Key? key}) : super(key: key);

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController completedController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List comChoice = ["", "true", "false"];
  String selectedChoice = '';
  List<DataModel> todos = [];
  bool fetching = true;
  int currentIndex = 0;
  final db = NewDatabase();

  @override
  void initState() {
    super.initState();
    db.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo Page"),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: userIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'User ID',
                  hintText: 'Old User ID: ${widget.data.userId}'
              ),
              validator: (value){
                return (value == '')? "Input User ID" : null;
              },
            ),
            TextFormField(
              controller: titleController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'TITLE',
                  hintText: 'Old Title: ${widget.data.title}'
              ),
              validator: (value){
                return (value == '')? "Input Title" : null;
              },
            ),
            const SizedBox(height: 20,),
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
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                int currentId =  widget.data.id;
                DataModel dataLocal = DataModel(
                    id:   currentId,
                    userId: int.parse(userIdController.text),
                    title: titleController.text,
                    completed: completedController.text);
                db.update(dataLocal, currentId);
                const snackBar = SnackBar(
                    content: Text('Updated Successfully')
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                });
                Navigator.pop(context, true);
              },
              child: const Text('Update To Do'),
            ),
          ],
        )
      ),
    );
  }
}
