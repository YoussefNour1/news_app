import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/layout/home_layout.dart';
import 'package:newsapp/network/cache_helper.dart';
import 'package:newsapp/network/dio_helper.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolData(key: "isDark");
  runApp(MyApp(isDark: isDark?? false));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({Key? key, required this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..newsBusinessData()..changeAppTheme(dark: isDark),
      child: BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            locale:
                const Locale.fromSubtags(countryCode: "eg", languageCode: "ar"),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
              primaryColor: Colors.green,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  titleSpacing: 5,
                  iconTheme: IconThemeData(color: Colors.black)),
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.green,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black26,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyText1:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              primaryTextTheme: TextTheme(
                  bodySmall: TextStyle(color: Colors.grey[700], fontSize: 11)),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.green,
              dividerColor: Colors.white60,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromRGBO(6, 16, 47, 1),
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  titleSpacing: 5,
                  iconTheme: IconThemeData(color: Colors.white)),
              backgroundColor: const Color.fromRGBO(6, 16, 47, 1),
              scaffoldBackgroundColor: const Color.fromRGBO(6, 16, 47, 1),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.green,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey,
                backgroundColor: Color.fromRGBO(6, 16, 47, 1),
                // type: BottomNavigationBarType.shifting,
              ),
              primaryTextTheme: TextTheme(
                  bodySmall: TextStyle(color: Colors.grey[300], fontSize: 11)),
              textTheme: const TextTheme(
                bodyText1:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            themeMode: cubit.isDark? ThemeMode.dark: ThemeMode.light,
            home: const HomeLayout(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
