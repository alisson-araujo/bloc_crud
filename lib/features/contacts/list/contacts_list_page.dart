import 'package:bloc_crud/features/contacts/list/bloc/contact_list_bloc.dart';
import 'package:bloc_crud/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact list')),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                BlocSelector<ContactListBloc, ContactListState,
                    List<ContactModel>>(
                  selector: (state) {
                    return state.maybeWhen(
                      data: (contacts) => contacts,
                      orElse: () => [],
                    );
                  },
                  builder: (_, contacts) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return ListTile(
                            title: Text(contact.name.toString()),
                            subtitle: Text(contact.email.toString()),
                          );
                        });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
