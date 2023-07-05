import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/View/Components/snack_bar.dart';
import 'package:hirehustle/View/Screens/Recommendations/recommendations.dart';
import 'package:hirehustle/ViewModel/StateManagement/Applied%20Applicants/applied_applicants_cubit.dart';

import '../../../ThemeData/app_theme.dart';
import '../../Components/Job Posts/custom_applicant_card.dart';

class ApplicantListScreen extends StatelessWidget {
  ApplicantListScreen({super.key, required this.jobPostId});

  int jobPostId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: BlocProvider<AppliedApplicantsCubit>(
        create: (context) =>
            AppliedApplicantsCubit()..getApplicantsById(jobPostId),
        child: BlocConsumer<AppliedApplicantsCubit, AppliedApplicantsState>(
          listener: (context, state) {
            if (state is AppliedApplicantsFetchedFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_bad_outlined,
                  text: state.failedMessage,
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ApiRequestFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_bad_outlined,
                  text: state.apiRequestErrorMessage,
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            AppliedApplicantsCubit appliedApplicantsCubit =
                BlocProvider.of(context);
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: AppliedApplicantsCubit.appliedApplicants == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(207, 97, 161, 1),
                      ),
                    )
                  : Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: ListView.separated(
                              separatorBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: MediaQuery.of(context).size.height / 200,
                                  color: AppColorLight.separationLineColor,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ApplicantListCard(
                                  context: context,
                                  username: AppliedApplicantsCubit.appliedApplicants[index]['username'],
                                  email: AppliedApplicantsCubit.appliedApplicants[index]['gmail'],
                                  applicantIndex: index,
                                );
                              },
                              itemCount: AppliedApplicantsCubit.appliedApplicants.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                            ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color.fromRGBO(177, 83, 126, 1.0),
                                      const Color(0xFF00CCFF)
                                    ],
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                  onPressed: () => NavigationHelper.navigateToWithAnimation(context, RecommendationsScreen(
                                      jobPostId: jobPostId,
                                      appliedApplicants: AppliedApplicantsCubit.appliedApplicants
                                  ),),
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    'Make Recommendations',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
