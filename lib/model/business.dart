import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';

import '../shared/shared.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.business;
        return buildArticle(list);
      },
    );
  }
}
