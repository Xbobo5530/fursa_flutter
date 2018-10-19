import 'package:flutter/material.dart';
import 'package:fursa_flutter/functions/functions.dart';
import 'package:fursa_flutter/models/categories.dart';
import 'package:fursa_flutter/values/strings.dart';

const tag = 'CreatePostPage';
final functions = Functions();

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  var _postImageUrl;
  var _desc;
  var _cats;
  var _selectedCats;
  var _catCheckboxValue;
  @override
  Widget build(BuildContext context) {
    _submitPost() {
      /// check if post already has content
      print('$tag submit has been clicked');
    }

    _addImage() {
      print('$tag add image has been clicked');
    }

    var imageSection = Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 45.0,
            ),
          ),
          onPressed: _addImage),
    );

    var descriptionSection = ListTile(
      leading: Icon(Icons.description),
      title: _desc != null
          ? Text(_desc)
          : Text(
              enterDescHint,
              style: TextStyle(color: Colors.black38),
            ),
      onTap: () => _openDescDialog(context),
    );

    var catsSection = ListTile(
      leading: Icon(Icons.apps),
      title: _cats != null
          ? Text(_getCats(_cats))
          : Text(
              enterCatsHint,
              style: TextStyle(color: Colors.black38),
            ),
      onTap: () => _openCatsDialog(context),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(newPostText),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text(submitText),
              onPressed: _submitPost,
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            imageSection,
            descriptionSection,
            catsSection,
          ],
        ));
  }

  _openDescDialog(BuildContext context) async {
    var descController = TextEditingController();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(labelText: enterDescHint),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(cancelText),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(doneText, style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  _setDescription(descController.text.trim());
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _setDescription(String description) {
    if (description.isNotEmpty)
      setState(() {
        _desc = description;
      });
  }

  String _getCats(cats) {
    var catsString = '';
    cats.forEach((category) {
      catsString += category;
    });
    return catsString;
  }

  _openCatsDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(categoriesText),
            content: StreamBuilder(
                stream: functions.database
                    .collection(CATEGORIES_COLLECTION)
                    .snapshots(),
                builder: (_, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (_, index) {
                          Category category = Category.fromSnapshot(
                              snapshots.data.documents[index]);
                          return ListTile(
                            //todo add the checkbox(fix)
//                            leading: Checkbox(
//                                value: _catCheckboxValue,
//                                onChanged: (isChecked) {
//                                  setState(() {
//                                    isChecked
//                                        ? _catCheckboxValue = !isChecked
//                                        : _catCheckboxValue = isChecked;
//                                    print('$tag isChecked = $isChecked');
//                                  });
//                                }),
                            title: Text(category.title),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            actions: <Widget>[
              FlatButton(
                child: Text(cancelText),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(doneText, style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  _handleSelectedCats();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  _handleSelectedCats() {}
}
