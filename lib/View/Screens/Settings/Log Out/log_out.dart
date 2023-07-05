import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirehustle/Helpers/CacheHelper.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:hirehustle/View/Screens/Login_Registration/login_screen.dart';

void customShowDialog({
  required context,
}) =>
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(34, 37, 61, 1.0), Colors.purple],
                begin: Alignment.center,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0.sp),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to logout?',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 20.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          NavigationHelper.navigateBack(context);
                        },
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          CacheHelper.clearCache().then(
                            (value) =>
                                NavigationHelper.navigateToAndRemoveUntil(
                              context,
                              LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
