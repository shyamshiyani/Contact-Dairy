// ignore_for_file: avoid_types_as_parameter_names

import 'package:contact_dairy/model/contact.dart';
import 'package:contact_dairy/provider/add_provider.dart';
import 'package:contact_dairy/provider/hide_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String pic =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqu7UbmJwzV1-X-HQL3xqN7W9DwcYMLzAKTQ&s";
  @override
  Widget build(BuildContext context) {
    AddDataProvider addContact =
        Provider.of<AddDataProvider>(context, listen: false);
    var dataadd = Provider.of<AddDataProvider>(context);
    var addData = Provider.of<AddDataProvider>(context, listen: false);
    Contact vcontact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () {
              addData.con_edit.nameCE.text = vcontact.name;
              addData.con_edit.emailCE.text = vcontact.email;
              addData.con_edit.contactCE.text = vcontact.contact;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Edit Contact"),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            addData.checkEditFillData(
                                vcontact,
                                addData.con_edit.nameCE.text,
                                addData.con_edit.emailCE.text,
                                addData.con_edit.contactCE.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Done")),
                    ],
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name"),
                          TextField(
                            controller: addData.con_edit.nameCE,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          const Text("Contact"),
                          TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            controller: addData.con_edit.contactCE,
                          ),
                          const Text("Email"),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: addData.con_edit.emailCE,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              final LocalAuthentication auth = LocalAuthentication();

              bool isAuth = await auth.authenticate(
                localizedReason: "Please Authenticate to showHidden Contacts",
                options: const AuthenticationOptions(),
              );
              if (isAuth) {
                Navigator.of(context).pushNamed("Hide");
                Provider.of<HideContactProvider>(context, listen: false)
                    .hideAdd(vcontact);
                addData.delData(
                    vcontact.name, vcontact.contact, vcontact.email);
              } else {
                ScaffoldMessenger(
                  child: SnackBar(
                    action: SnackBarAction(
                        label: "Pls Try again", onPressed: () {}),
                    content: Text(
                      "Please try again",
                    ),
                  ),
                );
              }
            },
            icon: const Icon(Icons.ios_share_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    CircleAvatar(
                      backgroundImage: NetworkImage("$pic"),
                      maxRadius: 50,
                    ),
                    Column(
                      children: [
                        Text(
                          vcontact.name,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(vcontact.email),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            vcontact.contact,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  final Uri url =
                                      Uri.parse('tel:${vcontact.contact}');
                                  await launchUrl(url);
                                },
                                icon: const Icon(
                                  Icons.call_outlined,
                                )),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                final Uri url =
                                    Uri.parse('sms:${vcontact.contact}');
                                await launchUrl(url);
                              },
                              icon: const Icon(
                                Icons.chat_outlined,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                final Uri url = Uri.parse(
                                    'mailto:${vcontact.email}?subject=News&body=');
                                await launchUrl(url);
                              },
                              icon: const Icon(
                                Icons.email_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          dataadd.deleteContact(vcontact);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Delete Contact",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
