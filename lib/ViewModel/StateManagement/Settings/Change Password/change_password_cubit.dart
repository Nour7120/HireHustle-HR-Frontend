import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  GlobalKey<FormState> formKey = new GlobalKey();


  List changePasswordData = [
    {
      'label': 'Your current password',
      'controller': new TextEditingController(),
    },
    {
      'label': 'Your new password',
      'controller': new TextEditingController(),
    },
    {
      'label': 'Confirm password',
      'controller': new TextEditingController(),
    }
  ];

  static bool currentPassObsecure = true;
  static bool newPassObsecure = true;
  static bool confirmPassObsecure = true;

  bool whichObsecure(label){
    switch(label) {
      case 'Your current password':
        return currentPassObsecure;
      case 'Your new password':
        return newPassObsecure;
      case 'Confirm password':
        return confirmPassObsecure;
      default:
        print('Invalid Label');
        return true;
    }
  }

  void triggerVisibility(label) {
    switch(label) {
      case 'Your current password':
        currentPassObsecure = !currentPassObsecure;
        emit(TriggerOldVisibility());
        break;
      case 'Your new password':
        newPassObsecure = !newPassObsecure;
        emit(TriggerNewVisibility());
        break;
      case 'Confirm password':
        confirmPassObsecure = !confirmPassObsecure;
        emit(TriggerConfirmationVisibility());
        break;
      default:
        print('Invalid Label');
    }
  }

  void changePassword() {
    if (formKey.currentState!.validate()) {
      if (changePasswordData[1]['controller'].text != changePasswordData[2]['controller'].text) {
        changePasswordData[2]['controller'].clear();
        emit(ConfirmationPasswordFailed());
      } else {
        // TODO: Change Password.
        changePasswordData[0]['controller'].clear();
        changePasswordData[1]['controller'].clear();
        changePasswordData[2]['controller'].clear();
      }
    }
  }

  void register(String jsonData) async{
    // Response response = await DioHelper.postAPI(endpoint: 'hr/register', data: jsonData);
    // if (response.statusCode == 200) {
    //   final jsonResponse = jsonDecode(response.data);
    //   if (jsonResponse['status'] == 'success') {
    //     String successMessage = jsonResponse['data'];
    //     clearAllControllers(fieldsData);
    //     emit(RegistrationSuccess(successMessage));
    //   }
    //   else if (jsonResponse['status'] == 'failed'){
    //     String failureMessage = jsonResponse['message'];
    //     emit(RegistrationFailed(failureMessage));
    //   }
    // }
    // else{
    //   String apiRequestErrorMessage = 'Sorry, There is a server request error.';
    //   emit(ApiRequestFailed(apiRequestErrorMessage));
    // }
  }
}
