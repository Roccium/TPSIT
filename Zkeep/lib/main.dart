import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_last_version/Databasecontroller.dart';
import 'model.dart';
import 'notifier.dart';
import 'widgets.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await deleteDatabase(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'am043 todo list',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff0cc87f))),
      home: ChangeNotifierProvider<TodoListNotifier>(
        create: (notifier) => TodoListNotifier(),
        child: const MyHomePage(title: 'am043 todo list'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _displayDialogForTodo(TodoListNotifier notifier, Contenitore contenitore) async {
    final TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aggiungi Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Scrivi qui...'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annulla'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Aggiungi'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  notifier.addTodoToContenitore(contenitore, controller.text,false);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
bool firsttimecheck = true;
  @override
  Widget build(BuildContext context) {
    Databasecontroller.istanza.database();
    final TodoListNotifier notifier = context.watch<TodoListNotifier>();
    if (firsttimecheck) {
      notifier.firstQuery();

      firsttimecheck = false;
    }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).shadowColor,
        elevation: 4,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          notifier.addContenitore();
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          itemCount: notifier.length_c,
          itemBuilder: (context, index) {
            Contenitore cont = notifier.getContainer(index);
            return ContenitoreItem(
              contenitore: cont,
              onTap: () {
                _displayDialogForTodo(notifier, cont);
              },
            );
          },
        ),
      ),
    );
  }
}
