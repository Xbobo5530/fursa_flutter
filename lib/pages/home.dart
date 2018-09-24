import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/post_functions.dart';
import 'package:fursa_flutter/views/people_tab.dart';
import 'package:fursa_flutter/views/posts_tab.dart';
import 'package:fursa_flutter/values/strings.dart';
import 'package:fursa_flutter/views/main_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text(APP_NAME),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.timelapse), text: recentText),
                Tab(icon: Icon(Icons.group), text: peopleText),
              ],
            )),
        drawer: new MainDrawerView(),
        body: TabBarView(
          children: [
            new PostsTabView(),
            new PeopleTabView(),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.red,
            child: new Icon(Icons.add),
            onPressed: () => new PostFunctions().createPost(context)),
      ),
    );
  }
}
