import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;
  const AddEditBookScreen({super.key, this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.book == null ? 'Add Book' : 'Edit Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Book Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) => value!.isEmpty ? 'Enter an author' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.book == null) {
                      bookProvider.addBook(_titleController.text, _authorController.text);
                    } else {
                      bookProvider.updateBook(widget.book!.id, _titleController.text, _authorController.text);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.book == null ? 'Add Book' : 'Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}