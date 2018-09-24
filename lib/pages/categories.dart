import 'package:flutter/material.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/categories_tab.dart';
import 'package:fursa_flutter/views/main_drawer.dart';
import 'package:fursa_flutter/views/tags_tab.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoriesText),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.apps), text: categoriesText),
              Tab(icon: Icon(Icons.local_offer), text: trendingTagsText),
            ]),
          ),
          drawer: new MainDrawerView(),
          body: TabBarView(
            children: [
              new CategoriesTabView(),
              new TagsTabView(),
            ],
          ),
          floatingActionButton:
              new FloatingActionButton(onPressed: () => createPost()),
        ));
  }

  createPost() {
    //todo hanlde create post, use a global functions call
  }
}
