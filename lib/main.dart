import 'package:flutter/material.dart';
import 'models/Task.dart';

void main() => runApp(TODOApp());

class TODOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TODO();
  }
}

class TODO extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TODOState();
  }
}

class TODOState extends State<TODO> {
  final List<Task> tasks = [];

  void onTaskCreated(String name) {
    if(name.length > 0) {
      setState(() {
        tasks.add(Task(name));
      });
    }
  }

  void onTaskToggled(Task task) {
    setState(() {
      task.setCompleted(!task.isCompleted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste de tâches',
      initialRoute: '/',
      routes: {
        '/': (context) => TODOList(tasks: tasks, onToggle: onTaskToggled),
        '/create': (context) => TODOCreate(onCreate: onTaskCreated,),
      },
    );
  }
}

class TODOList extends StatelessWidget {

  final List<Task> tasks;
  final onToggle;

  TODOList({@required this.tasks, @required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de tâches'),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(tasks[index].getName()),
              value: tasks[index].isCompleted(),
              onChanged: (_) => onToggle(tasks[index]),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/create'),
          child: Icon(Icons.add)
      ),
    );
  }
}

class TODOCreate extends StatefulWidget {

  final onCreate;
  TODOCreate({@required this.onCreate});
  @override
  State<StatefulWidget> createState() {
    return TODOCreateState();
  }
}

class TODOCreateState extends State<TODOCreate> {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une nouvelle tâche')),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(26),
              child: TextField(
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: 'Nom de la tâche'
                  )
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          widget.onCreate(controller.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}