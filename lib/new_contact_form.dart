import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/bloc/contact_bloc.dart';
import 'package:hive_tutorial/bloc/contact_event.dart';

import 'models/contact.dart';

class NewContactForm extends StatelessWidget {
  final _bloc = ContactBloc();

  void addContact(Contact contact) {
    final contactsBox = Hive.box('contacts');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _bloc.contact,
        builder: (context, snapshot) {
          return Form(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        onSaved: (value) => _bloc.updateNameValue(value),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _bloc.updateAgeValue(value),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Occupation'),
                        onSaved: (value) => _bloc.updateOccupationValue(value),
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Add New Contact'),
                  onPressed: () =>
                      _bloc.contactEventSink.add(AddNewContactEvent()),
                ),
              ],
            ),
          );
        });
  }
}
