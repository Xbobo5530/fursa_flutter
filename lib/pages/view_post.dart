import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/account_functions.dart';
import 'package:fursa_flutter/functions/post_functions.dart';
import 'package:fursa_flutter/models/post.dart';
import 'package:fursa_flutter/values/strings.dart';

class ViewPostPage extends StatelessWidget {
  final Post post;
  ViewPostPage(this.post);
  @override
  Widget build(BuildContext context) {
    String description;
    var desc = post.desc;
    var title = post.title;
    if (desc != null) {
      title != null ? description += '$title\n$desc' : description = desc;
    }

    var descriptionSection = description != null && description.isNotEmpty
        ? new ListTile(
            leading: Icon(Icons.description),
            title: Text(description),
          )
        : new Container();

    var contactInfoList = post.contactDetails;
    String contactString = '';
    if (contactInfoList != null) {
      for (String detailItem in contactInfoList) {
        contactString += '$detailItem\n';
      }
    }

    var contactSection =
        contactInfoList != null && contactString.trim().isNotEmpty
            ? new ListTile(
                leading: Icon(Icons.contacts), title: Text(contactString))
            : new Container();

    var locationInfoList = post.location;
    String locationString = '';
    if (locationInfoList != null) {
      for (String detailItem in locationInfoList) {
        locationString += '$detailItem\n';
      }
    }

    var locationSection =
        locationInfoList != null && locationString.trim().isNotEmpty
            ? new ListTile(
                leading: Icon(Icons.location_on),
                title: Text(locationString),
              )
            : new Container();

    var categoriesInfoList = post.categories;
    String categoriesString = '';
    if (categoriesInfoList != null) {
      categoriesInfoList.forEach((item) => categoriesString += '$item\n');
    }

    var categoriesSection =
        categoriesInfoList != null && categoriesString.trim().isNotEmpty
            ? new ListTile(
                leading: Icon(Icons.apps),
                title: Text(categoriesString),
              )
            : new Container();

    var tagsInfoList = post.tags;
    String tagsString = '';
    if (tagsInfoList != null) {
      tagsInfoList.forEach((item) => tagsString += '$item\n');
    }

    var tagsSection = tagsInfoList != null && tagsString.trim().isNotEmpty
        ? new ListTile(
            leading: Icon(Icons.local_offer),
            title: Text(tagsString),
          )
        : new Container();

    var userSection = ListTile(
      leading: post.userImageUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(post.userImageUrl),
            )
          : Icon(
              Icons.account_circle,
              size: 45.0,
              color: Colors.grey,
            ),
      title: Text(post.username),
      onTap: () =>
          new AccountFunctions().openUserProfileWithId(context, post.userId),
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(APP_NAME,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: post.imageUrl != null
                      ? Image.network(
                          post.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.blue,
                        )),
            )
          ];
        },
        body: ListView(
          children: <Widget>[
            descriptionSection,
            contactSection,
            locationSection,
            categoriesSection,
            tagsSection,
            userSection,
          ],
        ),
      ),
    );
  }
}
