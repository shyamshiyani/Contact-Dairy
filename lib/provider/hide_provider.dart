import 'package:contact_dairy/model/contact.dart';
import 'package:flutter/cupertino.dart';

class HideContactProvider extends ChangeNotifier {
  List Hide = [];

  void hideAdd(Contact contact) {
    Hide.add(contact);
    notifyListeners();
  }

  void hideRemove(Contact contact) {
    Hide.add(contact);
    notifyListeners();
  }
}
