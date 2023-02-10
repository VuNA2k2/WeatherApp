import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/repository/locations_repository.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/di/network_injection.dart';
import 'package:weather_app/model/constants.dart';
import 'package:weather_app/model/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/view/home_screen/bloc/home_bloc/home_bloc.dart';
import 'package:weather_app/view/home_screen/bloc/location_bloc/location_bloc.dart';
import 'package:weather_app/view/home_screen/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/view/widget/loading.dart';
import 'package:weather_app/view/widget/weather_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      BlocProvider<LocationBloc>(
          create: (_) =>
              LocationBloc(repository: getIt.get<LocationRepository>())
                ..add(LocationEventInit())),
      BlocProvider<WeatherBloc>(
          create: (_) =>
              WeatherBloc(repository: getIt.get<WeatherRepository>())),
    ], child: HomeScreenUI());
  }
}

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (_, __) {
        return _ is HomeStateSuccess && __ is HomeEventChange;
      },
      listener: (context, state) {
        // if (state is HomeStateChange) {
        //   context.read<WeatherBloc>().add(WeatherEventInit(locationId: state.selectLocation.id!, date: DateTime.now()));
        //
        // }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          dynamic locationState =
              context.select((LocationBloc bloc) => bloc.state);
          if (locationState is LocationStateSuccess) {
            locationState = locationState as LocationStateSuccess;
            context
                .read<HomeBloc>()
                .add(HomeEventInit(location: locationState.locations[0]));
          }
        } else if (state is HomeStateSuccess) {
          context.read<WeatherBloc>().add(WeatherEventInit(
              locationId: state.currentLocation.id!, date: DateTime.now()));
        }
        if (state is HomeStateSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Our profile image
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/profile.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    //our location dropdown
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/pin.png',
                          width: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        BlocConsumer<LocationBloc, LocationState>(
                            listenWhen: (pre, current) {
                          return pre is LocationStateSuccess &&
                              current is LocationStateChange;
                        }, listener: (context, state) {
                          // if(context.select((HomeBloc bloc) => bloc.state) is HomeStateSuccess)
                        }, builder: (context, state) {
                          return state is LocationStateSuccess
                              ? DropdownButtonHideUnderline(
                                  child: DropdownButton<Location>(
                                      value: state.currentLocation,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: state.locations.map((e) {
                                        return DropdownMenuItem<Location>(
                                            value: e,
                                            child: Text(
                                                '${e.country} | ${e.city}'));
                                      }).toList(),
                                      onChanged: (Location? value) {
                                        if (value != null) {
                                          state.currentLocation = value;
                                          context.read<HomeBloc>().add(
                                              HomeEventInit(location: value));
                                        }
                                      }),
                                )
                              : Container();
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.currentLocation.city}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Constants.primaryColor.withOpacity(.5),
                            offset: const Offset(0, 25),
                            blurRadius: 10,
                            spreadRadius: -12,
                          )
                        ]),
                    child: BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherStateSuccess) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -40,
                                left: 20,
                                child: Image.asset(
                                  'assets/' +
                                      (state.weather.status ?? 'unchecked') +
                                      '.png',
                                  width: 150,
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                left: 20,
                                child: Text(
                                  '${state.weather.status}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 20,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        '${state.weather.temperature}',
                                        style: TextStyle(
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = const LinearGradient(
                                              colors: <Color>[
                                                Color(0xffABCFF2),
                                                Color(0xff9AC6F3)
                                              ],
                                            ).createShader(const Rect.fromLTWH(
                                                0.0, 0.0, 200.0, 70.0)),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'o',
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = const LinearGradient(
                                            colors: <Color>[
                                              Color(0xffABCFF2),
                                              Color(0xff9AC6F3)
                                            ],
                                          ).createShader(const Rect.fromLTWH(
                                              0.0, 0.0, 200.0, 70.0)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        } else {
                          return Loading();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      return state is WeatherStateSuccess
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    text: 'Wind Speed',
                                    value: state.weather.windSpeed ?? 0,
                                    unit: 'km/h',
                                    imageUrl: 'assets/windspeed.png',
                                  ),
                                  WeatherItem(
                                      text: 'Humidity',
                                      value: state.weather.humidity ?? 0,
                                      unit: '',
                                      imageUrl: 'assets/humidity.png'),
                                  WeatherItem(
                                    text: 'Temperature',
                                    value: state.weather.temperature ?? 0,
                                    unit: 'C',
                                    imageUrl: 'assets/max-temp.png',
                                  ),
                                ],
                              ),
                            )
                          : Loading();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Next 7 Days',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Constants.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, state) {
                      if (state is WeatherStateSuccess) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.listWeatherOnWeek.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  margin: const EdgeInsets.only(
                                      right: 20, bottom: 10, top: 10),
                                  width: 80,
                                  decoration: const BoxDecoration(
                                      color: Constants.primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 5,
                                          color: Constants.primaryColor,
                                        ),
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${state.listWeatherOnWeek[index].temperature}' +
                                            "C",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/${state.listWeatherOnWeek[index].status}.png',
                                        width: 30,
                                      ),
                                      Text(
                                        DateFormat('dd/MM/yyyy').format(state
                                            .listWeatherOnWeek[index].date!),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else
                        return Loading();
                    },
                  ))
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
