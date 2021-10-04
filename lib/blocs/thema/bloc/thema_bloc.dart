import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'thema_event.dart';
part 'thema_state.dart';

class ThemaBloc extends Bloc<ThemaEvent, ThemaState> {
  ThemaBloc()
      : super(ThemaAppState(
            themeData: ThemeData.dark(), materialColor: Colors.purple));

  ThemaState get initialState =>
      ThemaAppState(themeData: ThemeData.light(), materialColor: Colors.purple);

  @override
  Stream<ThemaState> mapEventToState(ThemaEvent event) async* {
    ThemaAppState? themaAppState;
    if (event is ChangeThema) {
      switch (event.weatherStateAbbr) {
        case 'sn':
        case 'sl':
        case 'h':
        case 't':
        case 'hc':
          themaAppState = ThemaAppState(
              themeData: ThemeData(primaryColor: Colors.green),
              materialColor: Colors.grey);
          yield themaAppState;
          break;
        case 'hr':
        case 'lr':
        case 's':
          themaAppState = ThemaAppState(
              themeData: ThemeData(primaryColor: Colors.indigoAccent),
              materialColor: Colors.indigo);
          yield themaAppState;
          break;
        case 'lc':
        case 'c':
          themaAppState = ThemaAppState(
              themeData: ThemeData(primaryColor: Colors.yellow),
              materialColor: Colors.orange);

          yield themaAppState;
          break;
      }
      yield themaAppState!;
    }
  }
}
