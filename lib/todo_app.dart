import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Todo App")),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea
      (child:
      Padding(padding: 
      const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  const Text("Task Date:", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          )
        ],
      ),
      )
      ),
    );
  }
}