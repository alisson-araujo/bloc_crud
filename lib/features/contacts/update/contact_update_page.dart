import 'package:bloc_crud/features/contacts/update/bloc/contact_update_bloc.dart';
import 'package:bloc_crud/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loader.dart';

class ContactUpdatePage extends StatefulWidget {
  final ContactModel contact;

  const ContactUpdatePage({super.key, required this.contact});

  @override
  State<ContactUpdatePage> createState() => _ContactUpdatePageState();
}

class _ContactUpdatePageState extends State<ContactUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEc;
  late final TextEditingController _emailEc;

  @override
  void initState() {
    super.initState();
    _nameEc = TextEditingController(text: widget.contact.name);
    _emailEc = TextEditingController(text: widget.contact.email);
  }

  @override
  void dispose() {
    _nameEc.dispose();
    _emailEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact update'),
      ),
      body: BlocListener<ContactUpdateBloc, ContactUpdateState>(
        listener: (context, state) {
          state.whenOrNull(
            success: () => {
              Navigator.of(context).pop(),
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEc,
                  decoration: const InputDecoration(label: Text('nome')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailEc,
                  decoration: const InputDecoration(label: Text('email')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email é obrigatório';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      context
                          .read<ContactUpdateBloc>()
                          .add(ContactUpdateEvent.save(
                            id: widget.contact.id!,
                            name: _nameEc.text,
                            email: _emailEc.text,
                          ));
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactUpdateBloc, ContactUpdateState>(
                    selector: (state) {
                  return state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
