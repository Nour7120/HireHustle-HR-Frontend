import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:meta/meta.dart';

part 'applied_applicants_state.dart';

class AppliedApplicantsCubit extends Cubit<AppliedApplicantsState> {
  AppliedApplicantsCubit() : super(AppliedApplicantsInitial());

  static var appliedApplicants;

  void getApplicantsById(jobPostId) async {
    Response response =
        await DioHelper.getAPI(endpoint: 'hr/getAllApplicants/$jobPostId');
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse['status'] == 'success') {
        appliedApplicants = jsonResponse['data'];
        emit(AppliedApplicantsFetchedSuccess());
      } else if (jsonResponse['status'] == 'failed') {
        String FailedMessage = jsonResponse['message'];
        emit(AppliedApplicantsFetchedFailed(FailedMessage));
      }
    } else {
      String apiRequestErrorMessage = 'Sorry, there is a server error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }



}
