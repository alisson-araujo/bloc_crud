import 'package:bloc_crud/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:bloc_crud/features/contacts/list/contacts_list_page.dart';
import 'package:bloc_crud/features/contacts/register/contact_register_page.dart';
import 'package:bloc_crud/features/contacts/update/bloc/contact_update_bloc.dart';
import 'package:bloc_crud/features/contacts/update/contact_update_page.dart';
import 'package:bloc_crud/models/contact_model.dart';
import 'package:bloc_crud/repositories/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/contacts/register/bloc/contact_register_bloc.dart';
import 'home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ContactsRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        title: 'nandeska?',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          '/home': (_) => const HomePage(),
          '/contacts/list': (context) => BlocProvider(
                create: (_) => ContactListBloc(
                    repository: context.read<ContactsRepository>())
                  ..add(const ContactListEvent.findAll()),
                child: const ContactsListPage(),
              ),
          '/contacts/register': (context) => BlocProvider(
                create: (context) => ContactRegisterBloc(
                  contactsRepository: context.read(),
                ),
                child: const ContactRegisterPage(),
              ),
          '/contacts/update': (context) {
            final contact =
                ModalRoute.of(context)!.settings.arguments as ContactModel;
            return BlocProvider(
              create: (context) => ContactUpdateBloc(
                contactsRepository: context.read(),
              ),
              child: ContactUpdatePage(contact: contact),
            );
          }
        },
      ),
    );
  }
}
