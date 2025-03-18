import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? selectedDate;



  void _pickDate() {
    BottomPicker.date(
      pickerTitle: Text(
        'Set date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      initialDateTime: DateTime.now(),
      maxDateTime: DateTime(2100),
      minDateTime: DateTime(2000),
      pickerTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
    ).show(context);
  }


  void _submitData() {
    if (_formKey.currentState!.validate() && selectedDate != null) {
      setState(() {
        tasks.add({
          "title": _nameController.text,
          "deadline": DateFormat("dd-MM-yyyy HH:mm").format(selectedDate!),
          "done": false,
        });
        _nameController.clear();
        selectedDate = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tugas berhasil ditambahkan!"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  List<Map<String, dynamic>> tasks = [
    
  ];

  Widget _buildTaskItem(Map<String, dynamic> task, int index) {
    return Card(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(task["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deadline: ${task['deadline']}", style: const TextStyle(color: Colors.blueGrey)),
            Text(
              task["done"] ? "Selesai" : "Belum Selesai",
              style: TextStyle(color: task["done"] ? Colors.green : Colors.red),
            ),
          ],
        ),
        trailing: Checkbox(
          value: task["done"],
          onChanged: (bool? value) {
            setState(() {
              tasks[index]["done"] = value!;
            });
          },
          activeColor: Colors.purple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Todo App")),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Task Date:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        selectedDate != null
                            ? DateFormat(
                              "dd-MM-yyyy HH:mm",
                            ).format(selectedDate!)
                            : "Pilih tanggal",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _pickDate,
                    icon: const Icon(
                      Icons.date_range_rounded,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              if (selectedDate == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Silakan pilih tanggal",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 10),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama Tugas",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Masukkan nama tugas",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harap isi tugas";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Tambah Tugas", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("Daftar Tugas", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
