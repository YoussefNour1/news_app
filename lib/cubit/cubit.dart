import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/model/business.dart';
import 'package:newsapp/model/science.dart';
import 'package:newsapp/model/sport.dart';
import 'package:newsapp/network/cache_helper.dart';
import 'package:newsapp/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List screens = const [Business(), Sport(), Science()];
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  int currentIndex = 0;
  bool flag = false;
  bool isDark = false;
  IconData mode = Icons.dark_mode;
  ThemeMode theme = ThemeMode.light;
  void changeAppTheme({bool? dark}){
    if (dark != null) {
      isDark = dark;
    } else {
      isDark = !isDark;
    }
    CacheHelper.putBool(key: "isDark", value: isDark);
    emit(ModeState());
  }

  void changeBottom(int index) {
    currentIndex = index;
    switch (currentIndex) {
      case 1:
        newsSportsData();
        break;
      case 2:
        newsScienceData();
        break;
    }
    emit(ChangeBottomNavBar());
  }

  /*
  * https://newsapi.org/v2/top-headlines?country=eg&sortBy=publishedAt&apiKey=bdc414a1e3bf4a36b75888485be5fd5f*/
  dynamic business;
  dynamic sports;
  dynamic science;
  dynamic search;

  void newsBusinessData() {
    emit(LoadingState());
    DioHelper.getData(
      path: "v2/top-headlines",
      queries: {
        "language": "ar",
        "category": "business",
        "sortBy": "publishedAt",
        "apiKey": "bdc414a1e3bf4a36b75888485be5fd5f"
      },
    ).then((value) {
      business = value.data;
      emit(BusinessState());
    }).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void newsSportsData() {
    emit(LoadingState());
    DioHelper.getData(path: "v2/top-headlines", queries: {
      "language": "ar",
      "category": "sports",
      "sortBy": "publishedAt",
      "apiKey": "bdc414a1e3bf4a36b75888485be5fd5f",
    }).then((value) {
      sports = value.data;
      emit(SportsState());
    }).catchError((e){
      emit(ErrorState(e.toString()));
    });
  }

  void newsScienceData() {
    emit(LoadingState());
    DioHelper.getData(path: "v2/top-headlines", queries: {
      "language": "ar",
      "category": "science",
      "sortBy": "publishedAt",
      "apiKey": "bdc414a1e3bf4a36b75888485be5fd5f",
    }).then((value) {
      science = value.data;
      emit(ScienceState());
    }).catchError((e){
      emit(ErrorState(e.toString()));
    });
  }

  // https://newsapi.org/v2/everything?q=%D9%85%D8%B5%D8%B1&language=ar&sortBy=publishedAt&apiKey=bdc414a1e3bf4a36b75888485be5fd5f
  void searchNews({required String searchKey}){
    emit(LoadingState());
    DioHelper.searchData(path: "v2/everything", queries: {
      "language": "ar",
      "q": searchKey,
      "sortBy": "publishedAt",
      "apiKey": "bdc414a1e3bf4a36b75888485be5fd5f",
    }).then((value) {
      search = value.data;
      emit(SearchState());
    });
  }

}
