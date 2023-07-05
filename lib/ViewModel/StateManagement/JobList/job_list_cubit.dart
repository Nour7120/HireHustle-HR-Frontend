import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'job_list_state.dart';

class JobListCubit extends Cubit<JobListState> {
  JobListCubit() : super(JobListInitial());

  var jobList;

  void fetchAllValidJobPosts() async {
    Response response = await DioHelper.getAPI(
      endpoint: 'admin/allValidJobPosts',
    );
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      if (jsonResponse['status'] == 'success') {
        jobList = jsonResponse['data'];
        emit(JobFetchedSuccess());
      } else if (jsonResponse['status'] == 'failed') {
        String FailedMessage = jsonResponse['message'];
        emit(JobFetchFailed(FailedMessage));
      }
    } else {
      String apiRequestErrorMessage = 'Sorry, there is a server error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

  String convertDateFormat(inputDate) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDate);

    // Create a formatter to convert the date to the desired format
    DateFormat formatter = DateFormat('d/M/yyyy');

    // Format the date using the formatter
    String formattedDate = formatter.format(dateTime);

    // Return the formatted date
    return formattedDate;
  }

  String convertTimeFormat(String inputTime) {
    // Parse the input time string
    DateTime dateTime = DateTime.parse(inputTime);

    // Create a formatter to convert the time to the desired format
    DateFormat formatter = DateFormat('HH:mm');

    // Format the time using the formatter
    String formattedTime = formatter.format(dateTime);

    // Return the formatted time
    return formattedTime;
  }

  String convertDateTimeFormat(String inputDateTime){
    return 'Date: ${convertDateFormat(inputDateTime)} Time: ${convertTimeFormat(inputDateTime)}';
  }
}
