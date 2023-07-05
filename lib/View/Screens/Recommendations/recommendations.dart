import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/Recommendations/recommendations_cubit.dart';
import '../../Components/Recommendations/recommendation_card.dart';

class RecommendationsScreen extends StatelessWidget {
  RecommendationsScreen({super.key, this.jobPostId, this.appliedApplicants});

  var jobPostId;
  var appliedApplicants;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocProvider<RecommendationsCubit>(
        create: (context) => RecommendationsCubit()
          ..makeRecommendationsBySemanticSimilarity(
              jobPostId, appliedApplicants),
        child: BlocConsumer<RecommendationsCubit, RecommendationsState>(
          listener: (context, state) {},
          builder: (context, state) {
            RecommendationsCubit recommendationsCubit =
                BlocProvider.of(context);
            var applicants = RecommendationsCubit.sortedApplicants;
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: applicants == []
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(207, 97, 161, 1),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 200,
                                color: AppColorLight.separationLineColor,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return RecommendationListCard(
                                  context: context,
                                  username: applicants[index]['username'],
                                  applicantIndex: index,
                                  rate: recommendationsCubit.recommendationsResult.get(applicants[index]['id'].toString()),
                              );
                            },
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
