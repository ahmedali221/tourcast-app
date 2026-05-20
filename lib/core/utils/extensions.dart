import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isValidEmail =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPassword => length >= 8;
}

extension DoubleExtensions on double {
  // Format a number as currency: 1500.5 → "1,500.50 USD"
  String toCurrency({String symbol = 'USD'}) {
    return '${NumberFormat('#,##0.00').format(this)} $symbol';
  }
}

extension DateTimeExtensions on DateTime {
  String toReadable() => DateFormat('dd MMM yyyy').format(this);
  String toReadableWithTime() => DateFormat('dd MMM yyyy, hh:mm a').format(this);
}

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
