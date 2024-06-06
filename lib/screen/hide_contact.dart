import 'package:contact_dairy/provider/hide_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hide extends StatelessWidget {
  const Hide({super.key});

  @override
  Widget build(BuildContext context) {
    String pic =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqu7UbmJwzV1-X-HQL3xqN7W9DwcYMLzAKTQ&s";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Hidden Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: (Provider.of<HideContactProvider>(context).Hide.isNotEmpty)
          ? Column(
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
                        ...Provider.of<HideContactProvider>(context)
                            .Hide
                            .map((e) {
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
                                                MainAxisAlignment.spaceBetween,
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
