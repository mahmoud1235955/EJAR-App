import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/cubit/signup/sign_up_cubit.dart';
import 'package:test_ejar/presentation/settings/controllers/theme/cubit/theme_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDark = state is ThemeDark;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Theme",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ThemeCubit>().changeTheme();
                      },
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_outlined   // لو Dark يظهر الشمس
                            : Icons.dark_mode_outlined,  // لو Light يظهر القمر
                        size: 30,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                );
              },
            ),
            20.gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<SignUpCubit>().logout(context);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: 30,
                    color: Colors.greenAccent,
                  ),
                ),
              ])
          ],
        ),
      ),
    );
  }
}

//AIzaSyCQrX1OzIFEnl4t7_mNC7pLdyWCaaM3Mn0