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
                        onPressed: (){},
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
            ],
          ),
        ),
      ),
    );
  }
}
