import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/thema/bloc/thema_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weather_app/widget/background_color.dart';
import 'package:flutter_bloc_weather_app/widget/last_update.dart';
import 'package:flutter_bloc_weather_app/widget/location.dart';
import 'package:flutter_bloc_weather_app/widget/max_min_heat.dart';
import 'package:flutter_bloc_weather_app/widget/select_city.dart';
import 'package:flutter_bloc_weather_app/widget/weather_image.dart';

class WeatherApp extends StatelessWidget {
  String _selectedCity = 'Ankara';
  Completer<void> _refreshCompleter = Completer<void>();

  WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () async {
              _selectedCity = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectCityWidget()));
              if (_selectedCity.isNotEmpty) {
                _weatherBloc.add(FetchWeatherEvent(cityName: _selectedCity));
              } else {}
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (context, WeatherState state) {
            if (state is WeatherInitialState) {
              return const Center(child: Text('Please select city'));
            } else if (state is WeatherLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoadedState) {
              final responseWeather = state.weatherModel;
              BlocProvider.of<ThemaBloc>(context).add(ChangeThema(
                  weatherStateAbbr:
                      responseWeather.consolidatedWeather[0].weatherStateAbbr));
              _selectedCity = responseWeather.title;
              _refreshCompleter.complete();
              _refreshCompleter = Completer<void>();
              return BlocBuilder(
                bloc: BlocProvider.of<ThemaBloc>(context),
                builder: (context, state) {
                  return BackgroundColorWidget(
                    color: (state as ThemaAppState).materialColor,
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc
                            .add(RefreshWeatherEvent(cityName: _selectedCity));
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: LocationWidget(
                                    selectedCity: responseWeather.title)),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: LastUpdateWidget()),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: WeatherImageWidget()),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Center(child: MaxMinHeatWidget()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
