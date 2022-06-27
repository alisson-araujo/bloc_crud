part of 'contact_delete_bloc.dart';

@freezed
class ContactDeleteState with _$ContactDeleteState {
  const factory ContactDeleteState.initial() = _Initial;
  const factory ContactDeleteState.loading() = _Loading;
  const factory ContactDeleteState.erro({required String erro}) = _Erro;
  const factory ContactDeleteState.success() = _Success;
}
