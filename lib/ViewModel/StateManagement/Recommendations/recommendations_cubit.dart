import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../APIs/DioHelper.dart';
import '../Applied Applicants/applied_applicants_cubit.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit() : super(RecommendationsInitial());

  static late List sortedApplicants;
  late var recommendationsResult;

  Dio dio2 = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.6:5000/',
    receiveDataWhenStatusError: true,
    // connectTimeout: ,
    // receiveTimeout: ,
  ));

  void makeRecommendationsByTextSimilarity(
      var jobPostId,
      var appliedApplicants
      ) async {
    print("Enter Text");
    String? jobData = await getJobData(jobPostId);
    var jsonData = {
      "job_description" : jobData,
      "cvs": getApplicantsCVs(appliedApplicants)
    };

    // print(getApplicantsCVs(appliedApplicants));
    try {
      final response = await dio2.post(
          'text-similarity',
          data: jsonData,
          options: Options(
              contentType: 'application/json'
          )
      );
      if (response.statusCode == 200) {
        print(response.data);
      }
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }
  void makeRecommendationsBySemanticSimilarity(
      var jobPostId,
      var appliedApplicants
      ) async {
    print("Enter Semantic");
    String? jobData = await getJobData(jobPostId);
    var jsonData = {
      "job_description" : jobData,
      "cvs": getApplicantsCVs(appliedApplicants)
    };

    // print(getApplicantsCVs(appliedApplicants));
    try {
      final response = await dio2.post(
          'semantic-similarity',
          data: jsonData,
          options: Options(
              contentType: 'application/json'
          )
      );
      if (response.statusCode == 200) {
        print(response.data);
        recommendationsResult = response.data;
        handleRecommendationsSorting();
      }
    } on Exception catch (error) {
      print('Error during Post request: $error');
      rethrow;
    }
  }


  Future<String?> getJobData(jobPostId) async{
    Response response = await DioHelper.getAPI(endpoint: '/hr/getJobPostById/$jobPostId');
    if (response.statusCode == 200) {
      var jobJson = response.data['data'];
      return jobJson['jobDescription'] + jobJson['jobRequirements'];
    }
    else
      return "null";
  }

  Map<String, String> getApplicantsCVs(appliedApplicants){
    Map<String, String> applicantsMap = {};
    for(int i = 0; i < appliedApplicants.length; i++){
      applicantsMap[appliedApplicants[i]['id'].toString()] = appliedApplicants[i]['cvPlaceholder'];
    }
    print(applicantsMap);
    return applicantsMap;
  }

  void handleRecommendationsSorting(){
    var sortedRecommendations = sortMapByValuesDescending(recommendationsResult);

    List<Map<String, dynamic>> sortedList = List.from(AppliedApplicantsCubit.appliedApplicants);

    sortedList.sort((a, b) {
      String idA = a['id'].toString();
      String idB = b['id'].toString();

      int recommendationA = sortedRecommendations[idA] ?? 0;
      int recommendationB = sortedRecommendations[idB] ?? 0;

      return recommendationB.compareTo(recommendationA);
    });
    sortedApplicants = sortedList;
  }

  Map<dynamic, dynamic> sortMapByValuesDescending(Map<dynamic, dynamic> map) {
    List<MapEntry<dynamic, dynamic>> sortedEntries = map.entries.toList();

    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sortedEntries);
  }
}
