import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/shared.dart';

class Sport extends StatelessWidget {
  const Sport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.sports;
        return buildArticle(list);
      },
    );
  }
}
