import 'package:flutter/material.dart';
// import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override 
  State<HomePage> createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
  final List<String> _todos = ["Do something"];
  
  void _addJob(String job){
    setState(() {
      _todos.add(job);
    });
  }
  void _editJob(int index, String newJob){
    setState(() {
      _todos[index] = newJob;
    });
  }
  void _deleteJob(int index){
    setState(() {
      _todos.removeAt(index);
    });
  }
  void _showAddEdit({String? job,int? index}){
    final TextEditingController _textController = TextEditingController(text: job);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(job == null ?"Add Job":"Edit Job"),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: "Enter your job"
          ),
        ),
        actions:[
          TextButton(
            child: const Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
          
           TextButton(
              child: Text(job == null ? 'Add' : 'Save'),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  if (job == null) {
                    _addJob(_textController.text);
                  } else {
                    _editJob(index!, _textController.text);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("To Do App")),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(_todos[index]),
            trailing: SizedBox(
              width: 100,
              child:  Row(
              children: [
                IconButton(
                  onPressed: ()=>_showAddEdit(
                                              job: _todos[index],
                                              index: index,
                                ),
                 icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: ()=>_deleteJob(index),
                  icon: Icon(Icons.delete),
                )
              ],
              ),),
          );
        }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>_showAddEdit(),
          child: const Icon(Icons.add),
        )
    );
  }
}