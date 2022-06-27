part of 'contact_delete_bloc.dart';

@freezed
class ContactDeleteEvent with _$ContactDeleteEvent {
  const factory ContactDeleteEvent.delete({
    required String id,
    required String name,
    required String email,
  }) = _Delete;
}
