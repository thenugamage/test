import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:uuid/uuid.dart';

class BookProvider with ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(String title, String author) {
    _books.add(Book(id: const Uuid().v4(), title: title, author: author));
    notifyListeners();
  }

  void updateBook(String id, String title, String author) {
    final index = _books.indexWhere((book) => book.id == id);
    if (index != -1) {
      _books[index] = Book(id: id, title: title, author: author);
      notifyListeners();
    }
  }

  void deleteBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }
}