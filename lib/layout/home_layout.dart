import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/model/search.dart';

class HomeLayout extends StatelessWidget {

  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return BlocConsumer<NewsCubit, NewsState>(
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: const Text(
              "News",
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.changeAppTheme();
                  },
                  icon: Icon(
                      cubit.isDark? Icons.light_mode: Icons.dark_mode
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> Settings()));
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomNavItems,
            currentIndex: cubit.currentIndex,
            onTap: (int val) {
              cubit.changeBottom(val);
            },
            elevation: 25,
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
