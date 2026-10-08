import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();

  final List<Map<String, dynamic>> tasks = [
    {"title": "مذاكرة الرياضيات", "done": false},
    {"title": "قراءة كتاب", "done": false},
    {"title": "حل الواجب", "done": true},
  ];

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add({
        "title": controller.text.trim(),
        "done": false,
      });
      controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b1020),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "To-Do List",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            const Text(
              "نظم مهامك وحقق أهدافك",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xff151c2d),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task["done"],
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            task["done"] = value;
                          });
                        },
                      ),

                      title: Text(
                        task["title"],
                        style: TextStyle(
                          fontSize: 18,
                          decoration: task["done"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task["done"]
                              ? Colors.white38
                              : Colors.white,
                        ),
                      ),

                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "أضف مهمة جديدة...",
                      hintStyle:
                          const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xff151c2d),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => addTask(),
                  ),
                ),

                const SizedBox(width: 10),

                FloatingActionButton(
                  onPressed: addTask,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}