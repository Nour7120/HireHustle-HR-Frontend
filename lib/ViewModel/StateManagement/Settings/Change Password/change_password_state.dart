part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class TriggerOldVisibility extends ChangePasswordState {}

class TriggerNewVisibility extends ChangePasswordState {}

class TriggerConfirmationVisibility extends ChangePasswordState {}

class ConfirmationPasswordFailed extends ChangePasswordState {}
