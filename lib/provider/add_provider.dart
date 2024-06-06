import 'dart:io';

import 'package:contact_dairy/model/contact.dart';
import 'package:contact_dairy/model/controller.dart';
import 'package:contact_dairy/model/current_step.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDataProvider extends ChangeNotifier {
  CurrentStep cs = CurrentStep(currentStep: 0);

  List<Contact> allContact = [
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
    Contact(
      pic:
          'https://t4.ftcdn.net/jpg/05/11/55/91/360_F_511559113_UTxNAE1EP40z1qZ8hIzGNrB0LwqwjruK.jpg',
      name: "shyam",
      contact: "9632587410",
      email: "shyamshiyan1108@gmail.com",
    ),
  ];

  ControllerVar con_var = ControllerVar(
    nameC: TextEditingController(text: ''),
    emailC: TextEditingController(text: ''),
    contactC: TextEditingController(text: ''),
  );
  ControllerEditVar con_edit = ControllerEditVar(
      nameCE: TextEditingController(text: ''),
      emailCE: TextEditingController(text: ''),
      contactCE: TextEditingController(text: ''));

  void addContact(String name, String contact, String email) {
    Contact data = Contact(name: name, contact: contact, email: email, pic: '');
    allContact.add(data);
    notifyListeners();
  }

  void addData(String name, String contact, String email) {
    Contact data = Contact(pic: '', name: name, contact: contact, email: email);
    allContact.add(data);
    notifyListeners();
  }

  void delData(String name, String contact, String email) {
    Contact data = Contact(pic: '', name: name, contact: contact, email: email);

    allContact.remove(data);
    ChangeNotifier();
  }

  checkFillData() {
    if (con_var.nameC.text.isNotEmpty &&
        con_var.emailC.text.isNotEmpty &&
        con_var.contactC.text.isNotEmpty) {
      addData(con_var.nameC.text, con_var.contactC.text, con_var.emailC.text);

      con_var.contactC.clear();
      con_var.nameC.clear();
      con_var.emailC.clear();
    }
    notifyListeners();
  }

  checkEditFillData(
      Contact oldData, String name, String email, String contact) {
    if (allContact.contains(oldData)) {
      allContact.forEach((element) {
        if (element == oldData) {
          element.name = name;
          element.email = email;
          element.contact = contact;
        }
      });
    }
    con_edit.contactCE.clear();
    con_edit.nameCE.clear();
    con_edit.emailCE.clear();
    notifyListeners();
  }

  File? pickImage;
  imagePic() async {
    final ImagePicker picker = ImagePicker();

    XFile? res = await picker.pickImage(source: ImageSource.gallery);
    String? path = res!.path;
    pickImage = File(path);
    notifyListeners();
  }

  deleteContact(Contact data) {
    allContact.remove(data);
    notifyListeners();
  }

  checkContinueState() {
    if (cs.currentStep < 2) {
      cs.currentStep++;
    }
    notifyListeners();
  }

  checkCancelState() {
    if (cs.currentStep > 0) {
      cs.currentStep--;
    }
    notifyListeners();
  }
}
