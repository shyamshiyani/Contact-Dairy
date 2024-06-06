import 'package:contact_dairy/provider/add_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../provider/hide_provider.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    String pic =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqu7UbmJwzV1-X-HQL3xqN7W9DwcYMLzAKTQ&s";
    AddDataProvider addContact = Provider.of<AddDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Alert();
                  },
                );
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade400,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        child: Icon(
                          Icons.person,
                          size: 65,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Shyam Shiyani",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "+91 9784561230",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "shyamshiyani@gmail.com",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade800,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final LocalAuthentication auth =
                              LocalAuthentication();

                          bool isAuth = await auth.authenticate(
                            localizedReason:
                                "Please Authenticate to showHidden Contacts",
                            options: const AuthenticationOptions(),
                          );
                          if (isAuth) {
                            Navigator.of(context).pushNamed("Hide");
                          } else {
                            ScaffoldMessenger(
                              child: SnackBar(
                                action: SnackBarAction(
                                    label: "Pls Try again", onPressed: () {}),
                                content: const Text(
                                  "Please try again",
                                ),
                              ),
                            );
                          }
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.lock_person_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              "View hide Contacts",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: (addContact.allContact.isNotEmpty)
          ? Scrollbar(
              radius: Radius.circular(10),
              thickness: 5,
              trackVisibility: true,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey[600]),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search Contact',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...addContact.allContact.map((e) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('Details', arguments: e);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          10.0), // Add padding around the entire content
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 10),
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage('$pic', scale: 3),
                                            minRadius: 25,
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      e.contact,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons.call),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 800,
              width: double.infinity,
              color: Colors.grey,
              child: const Center(
                child: Text(
                  "No Contact ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    var addDataP = Provider.of<AddDataProvider>(context);
    return AlertDialog(
      title: const Text(
        'Add Contact',
      ),
      content: SizedBox(
        height: 400,
        width: 400,
        child: Stepper(
          controlsBuilder: (context, details) {
            if (addDataP.cs.currentStep == 0) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              );
            } else if (addDataP.cs.currentStep == 2) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkFillData();
                      addDataP.checkContinueState();
                      addDataP.cs.currentStep = 0;
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Finish',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      addDataP.checkContinueState();
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      addDataP.checkCancelState();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              );
            }
          },
          currentStep: addDataP.cs.currentStep,
          steps: <Step>[
            Step(
              state: (addDataP.cs.currentStep == 0)
                  ? StepState.editing
                  : (addDataP.con_var.nameC.text.isEmpty)
                      ? StepState.error
                      : StepState.complete,
              title: const Text('Name'),
              content: TextField(
                controller: addDataP.con_var.nameC,
                decoration: const InputDecoration(hintText: 'Enter your name'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 1)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 1)
                      ? StepState.editing
                      : (addDataP.con_var.contactC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Contact'),
              content: TextField(
                controller: addDataP.con_var.contactC,
                decoration:
                    const InputDecoration(hintText: 'Enter your Contact'),
              ),
            ),
            Step(
              state: (addDataP.cs.currentStep < 2)
                  ? StepState.indexed
                  : (addDataP.cs.currentStep == 2)
                      ? StepState.editing
                      : (addDataP.con_var.emailC.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: const Text('Email'),
              content: TextField(
                controller: addDataP.con_var.emailC,
                decoration: const InputDecoration(hintText: 'Enter your Email'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
