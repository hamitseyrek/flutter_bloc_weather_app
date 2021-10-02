import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/thema/bloc/thema_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weather_app/data/weather_repository.dart';
import 'package:flutter_bloc_weather_app/locator.dart';
import 'package:flutter_bloc_weather_app/widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<ThemaBloc>(
    create: (context) => ThemaBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _themaBloc = BlocProvider.of<ThemaBloc>(context);

    return BlocBuilder(
      bloc: _themaBloc,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: (state as ThemaAppState).themeData,
          home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(WeatherRepository()),
            child: WeatherApp(),
          ),
        );
      },
    );
  }
}
