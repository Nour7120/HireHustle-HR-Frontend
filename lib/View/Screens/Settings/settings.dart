import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/Settings/settings_screen_cubit.dart';
import '../../Components/Settings/custom_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsScreenCubit, SettingsScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SettingsScreenCubit settingsScreenCubit = BlocProvider.of(context);
        return Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                MaterialButton(
                  onPressed: () {},
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: ListTile(
                    leading: ClipOval(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.width / 7,
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/main_profile_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      'Nour Amr',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    subtitle: Text(
                      'View your profile',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                ListView.separated(
                  itemBuilder: (context, index) => customListTile(
                    context: context,
                    leadingIcon: settingsScreenCubit.settingsTiles[index]
                        ['leadingIcon'],
                    title: settingsScreenCubit.settingsTiles[index]['title'],
                    onPressed: settingsScreenCubit.settingsListNavigation(
                      context: context,
                      title: settingsScreenCubit.settingsTiles[index]['title'],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemCount: settingsScreenCubit.settingsTiles.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
