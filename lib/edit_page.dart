import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/models/contact.dart';

class EditPage extends StatefulWidget {
  final int index;
  final Contact contact;

  EditPage({this.index, this.contact});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _age;
  String _occupation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Edit Page"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  initialValue: widget.contact.name,
                  decoration: InputDecoration(hintText: 'name'),
                  onSaved: (value) {
                    _name = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  initialValue: widget.contact.age.toString(),
                  decoration: InputDecoration(hintText: 'age'),
                  onSaved: (value) {
                    _age = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  initialValue: widget.contact.occupation,
                  decoration: InputDecoration(
                    hintText: 'occupation',
                  ),
                  onSaved: (value) {
                    _occupation = value;
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () {
            _formKey.currentState.save();
            final contactsBox = Hive.box('contacts');
            contactsBox.putAt(
              widget.index,
              Contact(_name, int.parse(_age), _occupation),
            );
            _formKey.currentState.reset();

            return Navigator.pop(context);
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
          },
          tooltip: 'Show me the value!',
          child: Icon(Icons.text_fields),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return null;
}
