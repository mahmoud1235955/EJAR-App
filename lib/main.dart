import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/SharedPrefrances/shared_prefrances.dart';
import 'package:test_ejar/firebase_options.dart';
import 'package:test_ejar/presentation/account/routes/account_navbar_routes.dart';
import 'package:test_ejar/presentation/account/screens/account_screen.dart';
import 'package:test_ejar/presentation/asds/routes/ads_navbar_route.dart';
import 'package:test_ejar/presentation/asds/screens/ads_screen.dart';
import 'package:test_ejar/presentation/asds/screens/maps.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';
import 'package:test_ejar/presentation/chats/screens/chats_screen.dart';
import 'package:test_ejar/presentation/chats/screens/view_chat_screen.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/cubit/signup/sign_up_cubit.dart';
import 'package:test_ejar/presentation/home/controllers/controllers%20copy/login/cubit/log_in_cubit.dart';
import 'package:test_ejar/presentation/home/controllers/icons/cubit/icons_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cars/cubit/cars_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/database_cubit.dart';
import 'package:test_ejar/presentation/rent/screens/cars_screen.dart';
import 'package:test_ejar/presentation/rent/screens/carscreen/car_view_all.dart';
import 'package:test_ejar/presentation/rent/screens/carscreen/carsScreen_view.dart';
import 'package:test_ejar/presentation/rent/screens/home_repair_screen.dart';
import 'package:test_ejar/presentation/rent/screens/real_estate_screen.dart';
import 'package:test_ejar/presentation/rent/screens/smart_equipment_screen.dart';
import 'package:test_ejar/presentation/settings/controllers/theme/cubit/theme_cubit.dart';
import 'package:test_ejar/presentation/settings/routes/settings_nav_screen.dart';
import 'package:test_ejar/presentation/settings/screens/settings_screen.dart';
import 'package:test_ejar/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_ejar/splash/splash_screen.dart';
import 'presentation/home/screens/forgot_screen.dart';
import 'presentation/home/screens/home_screen.dart';
import 'presentation/home/screens/login_screen.dart';
import 'presentation/home/screens/onboarding_screen.dart';
import 'presentation/home/screens/signUp_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.initial();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => CarsCubit(null)),
        BlocProvider(create: (context) => IconsCubit()),
        BlocProvider(
          create: (context) => SignUpCubit(context.read<LogInCubit>(), context),
        ),
        BlocProvider(create: (context) => ThemeCubit()..initTheme()),
        BlocProvider(create: (context) => DatabaseCubit()..readData()),
        BlocProvider(create: (context) => AddProductCubit()..getCarsStream()),
        BlocProvider(create: (context) => ChatsCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            initialRoute: Routes.splash,
            routes: {
              Routes.chats: (context) => const ChatScreen(),
              Routes.maps: (context) => MapSample(),
              Routes.splash: (context) => SplashScreen(),
              Routes.home: (context) => HomeScreen(),
              Routes.login: (context) => LoginScreen(),
              Routes.signUp: (context) => SignUpScreen(),
              Routes.forgot: (context) => ForgotScreen(),
              Routes.onboarding: (context) => OnboardingScreen(),
              Routes.carsScreen: (context) => CarsScreen(),
              Routes.carsView: (context) => CarsscreenView(),
              Routes.realEstateView: (context) => RealEstateScreen(),
              Routes.smartEquipment: (context) => SmartEquipmentScreen(),
              Routes.homeRepairView: (context) => HomeRepairScreen(),
              Routes.carViewAll: (context) => CarViewAll(),
              AccountNavbarRoutes.accountNav: (context) => AccountScreen(),
              AdsNavbarRoute.adsNav: (context) => AdsScreen(),
              SettingsNavScreen.settingsNav: (context) =>
                  const SettingsScreen(),
              Routes.viewChats: (context) => ViewChatScreen(),

              // ✅ ChatScreen with arguments
            },
          );
        },
      ),
    );
  }
}
