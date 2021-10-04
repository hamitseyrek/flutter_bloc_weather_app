import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/weather/bloc/weather_bloc.dart';

class WeatherImageWidget extends StatelessWidget {
  const WeatherImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, state) {
        var responseImage = (state as WeatherLoadedState)
            .weatherModel
            .consolidatedWeather[0]
            .weatherStateAbbr;
        var responseTemp =
            (state).weatherModel.consolidatedWeather[0].theTemp.floor();
        return Column(
          children: [
            Text(
              responseTemp.toString() + '°C',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Image.network(
              'https://www.metaweather.com/static/img/weather/png/' +
                  responseImage.toString() +
                  '.png',
              width: 150,
            ),
          ],
        );
      },
    );
  }
}
