import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/bloc/contact_event.dart';
import 'package:hive_tutorial/models/contact.dart';

class ContactBloc {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _age;
  String _occupation;

  final _contactStateController = StreamController<dynamic>();
  StreamSink<dynamic> get _inContact => _contactStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<dynamic> get contact => _contactStateController.stream;

  final _contactEventController = StreamController<ContactEvent>();
  // For events, exposing only a sink which is an input
  Sink<ContactEvent> get contactEventSink => _contactEventController.sink;

  get formKey {
    return _formKey;
  }

  void addContact(Contact contact) {
    final contactsBox = Hive.box('contacts');
    contactsBox.add(contact);
  }

  String updateNameValue(String value) {
    return _name = value;
  }

  String updateAgeValue(String value) {
    return _age = value;
  }

  String updateOccupationValue(String value) {
    return _occupation = value;
  }

  ContactBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _contactEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ContactEvent event) {
    // TODO: Add Logic
    if (event is AddNewContactEvent) {
      _inContact.add(updateNameValue(_name));
      _inContact.add(updateAgeValue(_age));
      _inContact.add(updateOccupationValue(_occupation));
      _formKey.currentState.save();
      final newContact = Contact(_name, int.parse(_age), _occupation);
      addContact(newContact);
    }
  }

  void dispose() {
    _contactStateController.close();
    _contactEventController.close();
  }

  // TODO: implement initialState
  get initialState => null;
}

@override
Stream mapEventToState(event) {
  // TODO: implement mapEventToState
  return null;
}
