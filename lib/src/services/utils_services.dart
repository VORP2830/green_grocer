import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> deleteLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(price);
  }

  String formatDateTime(DateTime datetime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(datetime.toLocal());
  }

  Uint8List decodeQrCodeImage(String value) {
    return base64.decode(value.split(',').last);
  }

  void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    );
  }
}
