import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared/shared.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  var textControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      builder: (context, state){
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children: [
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
                autofocus: true,
                controller: textControl,
                onSubmitted: (val){
                  cubit.searchNews(searchKey: val);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: Theme.of(context).primaryTextTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: SizedBox(
                  child: buildArticle(cubit.search),
                  width: double.infinity,
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state){},

    );
  }
}
