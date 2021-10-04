import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather_app/blocs/weather/bloc/weather_bloc.dart';

class LastUpdateWidget extends StatelessWidget {
  const LastUpdateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, state) {
        var responseDate =
            DateTime.parse((state as WeatherLoadedState).weatherModel.time)
                .toLocal();
        return Text(
          'Last update: ' +
              TimeOfDay.fromDateTime(responseDate).format(context),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}
