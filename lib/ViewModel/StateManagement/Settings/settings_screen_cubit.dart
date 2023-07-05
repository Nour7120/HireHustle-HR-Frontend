import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hirehustle/Helpers/NavigationHelper.dart';
import 'package:meta/meta.dart';

import '../../../View/Screens/Settings/Change Password/change_password.dart';
import '../../../View/Screens/Settings/Contact Us/contact_us.dart';
import '../../../View/Screens/Settings/Dark Mode/dark_mode.dart';
import '../../../View/Screens/Settings/Log Out/log_out.dart';
import '../../../View/Screens/Settings/Notifications/notification_screen.dart';
import '../../../View/Screens/Settings/Terms & Privacy/terms_privacy.dart';

part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  SettingsScreenCubit() : super(SettingsScreenInitial());

  List settingsTiles = [
    {
      'leadingIcon': Icons.chat_bubble_outline,
      'title': 'Contact Us',
    },
    {
      'leadingIcon': Icons.notifications_active_outlined,
      'title': 'Notifications',
    },
    {
      'leadingIcon': Icons.dark_mode_outlined,
      'title': 'Dark Mode',
    },
    {
      'leadingIcon': Icons.lock_outline,
      'title': 'Change Password',
    },
    {
      'leadingIcon': Icons.policy_outlined,
      'title': 'Terms of Use & Privacy Policy',
    },
    {
      'leadingIcon': Icons.logout,
      'title': 'Log Out',
    },
  ];

  dynamic settingsListNavigation({context, title}) {
    switch (title) {
      case 'Contact Us':
        return () => NavigationHelper.navigateTo(context, ContactUsScreen());
      case 'Notifications':
        return () => NavigationHelper.navigateTo(context, NotificationScreen());
      case 'Dark Mode':
        return () => NavigationHelper.navigateTo(context, DarkMode());
      case 'Change Password':
        return () => NavigationHelper.navigateTo(context, ChangePassword());
      case 'Terms of Use & Privacy Policy':
        return () => NavigationHelper.navigateTo(context, TermsPrivacyScreen());
      case 'Log Out':
        return () => customShowDialog(context: context);
      default:
        print("Error");
    }
  }
}
