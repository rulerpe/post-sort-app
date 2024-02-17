import 'package:DuXin/pages/summary_page.dart';
import 'package:flutter/material.dart';

class SummaryPageArgumentsProvider with ChangeNotifier {
  SummaryPageArguments? _args;

  SummaryPageArguments? get args => _args;

  void setArgs(SummaryPageArguments args) {
    _args = args;
    notifyListeners();
  }
}
