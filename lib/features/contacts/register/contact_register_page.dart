import 'package:bloc_crud/features/contacts/register/bloc/contact_register_bloc.dart';
import 'package:bloc_crud/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactRegisterPage extends StatefulWidget {
  const ContactRegisterPage({Key? key}) : super(key: key);

  @override
  State<ContactRegisterPage> createState() => _ContactRegisterPageState();
}

class _ContactRegisterPageState extends State<ContactRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEc = TextEditingController();
  final _emailEc = TextEditingController();

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
        title: const Text('Contact register'),
      ),
      body: BlocListener<ContactRegisterBloc, ContactRegisterState>(
        listenWhen: (previous, current) {
          return current.maybeWhen(
            success: () => true,
            error: (_) => true,
            orElse: () => false,
          );
        },
        listener: (context, state) {
          state.whenOrNull(success: () {
            Navigator.of(context).pop();
          }, error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          });
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      context.read<ContactRegisterBloc>().add(
                            ContactRegisterEvent.save(
                              name: _nameEc.text,
                              email: _emailEc.text,
                            ),
                          );
                    }
                  },
                  child: const Text('Salvar'),
                ),
                Loader<ContactRegisterBloc, ContactRegisterState>(
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
