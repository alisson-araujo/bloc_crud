import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_crud/models/contact_model.dart';
import 'package:bloc_crud/repositories/contacts_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_delete_event.dart';
part 'contact_delete_state.dart';
part 'contact_delete_bloc.freezed.dart';

class ContactDeleteBloc extends Bloc<ContactDeleteEvent, ContactDeleteState> {
  final ContactsRepository _contactsRepository;

  ContactDeleteBloc({required ContactsRepository contactsRepository})
      : _contactsRepository = contactsRepository,
        super(const _Initial()) {
    on<_Delete>(_delete);
  }

  FutureOr<void> _delete(
      _Delete event, Emitter<ContactDeleteState> emit) async {
    try {
      emit(const ContactDeleteState.loading());
      final model = ContactModel(
        id: event.id,
        name: event.name,
        email: event.email,
      );
      await _contactsRepository.delete(model);
      emit(const ContactDeleteState.success());
    } catch (e, s) {
      log('Erro ao deletar contato', error: e, stackTrace: s);
      emit(const ContactDeleteState.erro(erro: 'Erro ao deletar contato'));
    }
  }
}
