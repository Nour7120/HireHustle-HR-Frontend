import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Components/Settings/Contact Us/custom_fiels.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Column(
                    children: [
                      customField(
                        context: context,
                        title: 'E-mail',
                        fieldContent: 'hire1hustle@gmail.com',
                        fieldLeadingIcon: Icons.mail_outline_rounded,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      customField(
                        context: context,
                        title: 'General Management',
                        fieldContent: 'Cairo, Egypt',
                        fieldLeadingIcon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
