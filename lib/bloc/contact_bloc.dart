import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_tutorial/models/contact.dart';
import './bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
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

  @override
  ContactState get initialState => InitialContactState();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is AddNewContactEvent) {
      _inContact.add(updateNameValue(_name));
      _inContact.add(updateAgeValue(_age));
      _inContact.add(updateOccupationValue(_occupation));

      final newContact = Contact(_name, int.parse(_age), _occupation);
      addContact(newContact);
    }
  }

  void dispose() {
    _contactStateController.close();
    _contactEventController.close();
  }
}
