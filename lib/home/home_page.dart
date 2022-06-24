import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('omaewamouashindeiru'),
        ),
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/contacts/list'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    height: 70,
                    width: 70,
                    child: const Center(child: Text('Contacts')),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
