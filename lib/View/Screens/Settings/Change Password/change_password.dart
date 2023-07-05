import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../ViewModel/StateManagement/Settings/Change Password/change_password_cubit.dart';
import '../../../Components/Settings/Change Password/custom_text_form_field.dart';
import '../../../Components/snack_bar.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ConfirmationPasswordFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(
                  icon: Icons.mood_bad_outlined,
                  text: 'Sorry, Confirmation password is not the same.',
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            ChangePasswordCubit changePasswordCubit = BlocProvider.of(context);
            return Container(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 15.h),
                child: Form(
                  key: changePasswordCubit.formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create new password',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Your new password must be different from previous used passwords.',
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, color: Colors.white60),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              CustomChangePasswordTextFormField(
                            labelText: changePasswordCubit
                                .changePasswordData[index]['label'],
                            labelColor: Colors.white,
                            textColor: Colors.white,
                            cursorColor: Colors.white,
                            borderColor: Colors.transparent,
                            borderRadius: 10.sp,
                            borderWidth: 2.w,
                            focusedBorderColor: Color.fromRGBO(22, 208, 227, 1),
                            focusedBorderRadius: 10.sp,
                            focusedBorderWidth: 2.w,
                            obsecureText: changePasswordCubit.whichObsecure(
                              changePasswordCubit.changePasswordData[index]
                                  ['label'],
                            ),
                            triggerVisibilityFunction:
                                changePasswordCubit.triggerVisibility,
                            suffixIcon: changePasswordCubit.whichObsecure(
                              changePasswordCubit.changePasswordData[index]
                                  ['label'],
                            )
                                ? Icons.visibility_off
                                : Icons.visibility,
                            controller: changePasswordCubit
                                .changePasswordData[index]['controller'],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 20.h,
                          ),
                          itemCount:
                              changePasswordCubit.changePasswordData.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          child: TextButton(
                            onPressed: () => changePasswordCubit.changePassword(),
                            child: Text(
                              'Change Password',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(22, 208, 227, 1),
                                Colors.purple
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
