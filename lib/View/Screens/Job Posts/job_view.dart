import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/ViewModel/StateManagement/JobList/job_list_cubit.dart';
import 'package:hirehustle/ViewModel/StateManagement/JobList/job_list_cubit.dart';
import '../../../ThemeData/app_theme.dart';
import '../../Components/Registration/secondary_button.dart';
import 'applied_applicants.dart';

class JobViewScreen extends StatelessWidget {
  JobViewScreen({super.key, required this.jobPostIndex, required this.jobPostId});

  int jobPostIndex;
  int jobPostId;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'jobCard$jobPostIndex',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/main_background.png',
              ),
              fit: BoxFit.fill),
        ),
        child: BlocConsumer<JobListCubit, JobListState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            JobListCubit jobListCubit = BlocProvider.of(context);
            var jobDetails = [
              'jobDescription',
              'jobRequirements',
              'overtime',
              'benefits',
              'additionalRequirements',
              'expirationPeriod',
              'creationTime'
            ];
            var jobDetailsLabel = [
              'Job Description',
              'Job Requirements',
              'Overtime',
              'Benefits',
              'Additional Requirements',
              'Expiration Period',
              'Creation Time'
            ];
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: PopupMenuButton(
                      splashRadius: 0,
                      color: AppColorLight.contactUsTextFieldColor,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          onTap: () {
                            //TODO: implement update job
                          },
                          value: 'update',
                          child: Text(
                            'Update Job Post',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuItem<String>(
                          onTap: () {
                            //TODO: implement delete job
                          },
                          value: 'end',
                          child: Text(
                            'End Job Request',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: Image.asset(
                        'assets/images/${jobListCubit.jobList[jobPostIndex]['jobCategory']}.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 42, 57, 1.0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    jobListCubit.jobList[jobPostIndex]
                                        ['jobTitle'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    jobListCubit.jobList[jobPostIndex]
                                        ['jobCategory'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromRGBO(177, 83, 126, 1.0),
                                  ),
                                  Text(
                                    jobListCubit.jobList[jobPostIndex]
                                        ['jobLocation'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Color.fromRGBO(97, 165, 207, 1.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.work_history_outlined,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          jobListCubit.jobList[jobPostIndex]
                                                  ['workingHours'] +
                                              ' hours',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Color.fromRGBO(97, 165, 207, 1.0),
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.003,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_money_outlined,
                                          color:
                                              Color.fromRGBO(177, 83, 126, 1.0),
                                        ),
                                        Text(
                                          jobListCubit.jobList[jobPostIndex]
                                              ['salary'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              ListView.separated(
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobDetailsLabel[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      jobDetailsLabel[index] ==
                                                  'Expiration Period' ||
                                              jobDetailsLabel[index] ==
                                                  'Creation Time'
                                          ? jobListCubit.convertDateTimeFormat(
                                              jobListCubit.jobList[jobPostIndex]
                                                  [jobDetails[index]])
                                          : jobListCubit.jobList[jobPostIndex]
                                              [jobDetails[index]],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                                separatorBuilder: (context, index) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                itemCount: jobDetailsLabel.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Row(
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
                                      onPressed: () => NavigationHelper.navigateTo(context, ApplicantListScreen(jobPostId: jobPostId,)),
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Show Applicants',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
