import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => InitialContactState();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
