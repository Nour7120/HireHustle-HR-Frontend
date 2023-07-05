import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirehustle/ViewModel/StateManagement/JobList/job_list_cubit.dart';

import '../../../ThemeData/app_theme.dart';
import '../../Components/Job Posts/custom_job_card.dart';
import '../../Components/snack_bar.dart';

class JobList extends StatelessWidget {
  const JobList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobListCubit, JobListState>(
      listener: (context, state) {
        if (state is ApiRequestFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              icon: Icons.mood_bad_outlined,
              text: state.apiRequestErrorMessage,
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is JobFetchFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              icon: Icons.mood_bad_outlined,
              text: state.FailedMessage,
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        JobListCubit jobListCubit = BlocProvider.of(context);
        var validJobPosts = jobListCubit.jobList;
        return Container(
          color: Colors.transparent,
          child: validJobPosts == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(207, 97, 161, 1),
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 200,
                      color: AppColorLight.separationLineColor,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return JobListCard(
                      context: context,
                      jobTitle: validJobPosts[index]['jobTitle'],
                      jobCategory: validJobPosts[index]['jobCategory'],
                      jobLocation: validJobPosts[index]['jobLocation'],
                      jobCreationTime: jobListCubit.convertDateFormat(
                        validJobPosts[index]['creationTime'],
                      ),
                      jobPostIndex: index,
                      jobPostId: validJobPosts[index]['id'],
                    );
                  },
                  itemCount: validJobPosts.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                ),
        );
      },
    );
  }
}
