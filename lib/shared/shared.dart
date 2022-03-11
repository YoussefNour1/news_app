import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/model/web.dart';

Widget buildArticle(list) {
  return ConditionalBuilder(
      condition: list != null,
      builder: (context) {
        return articleBuilder(list);
      },
      fallback: (context) {
        return const Center(child: CircularProgressIndicator());
      });
}

ListView articleBuilder(list) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      var x = list["articles"][index]["urlToImage"];
      var url = list["articles"][index]["url"];
      return InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> Webview(url: url,)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                         x??
                            "https://uploads-us-west-2.insided.com/looker-en/attachment/d0a25f59-c9b7-40bd-b98e-de785bbd04e7.png",
                      ),
                      onError: (ob, s){
                        x = Image.network("https://uploads-us-west-2.insided.com/looker-en/attachment/d0a25f59-c9b7-40bd-b98e-de785bbd04e7.png");
                      },
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list["articles"][index]["title"],
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list["articles"][index]["source"]['name'] ?? " ",
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                              ),
                              Text(
                                list["articles"][index]["publishedAt"].split('T')[0] ??
                                    " ",
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      );
    },
    separatorBuilder: (context, _) => const Divider(
      height: 10,
      endIndent: 10,
      indent: 10,

    ),
    itemCount: list["articles"].length,
  );
}
