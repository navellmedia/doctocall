import 'package:doctorcall/coreapp/service/session_management.dart';
import 'package:doctorcall/features/home_feature/bloc/home_bloc.dart';
import 'package:doctorcall/features/home_feature/models/population_response.dart';
import 'package:doctorcall/features/login_feature/models/user_response.dart';
import 'package:doctorcall/features/news_feature/models/news_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../coreapp/routing/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserResponse? _userResponse;
  HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    getUserSession();
    _homeBloc.add(GetDataNews());
  }

  void getUserSession() async {
    var data = await SessionManagement.getUserData();
    _userResponse = data;
    setState(() {
      _userResponse = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16),
          child: BlocConsumer(
            bloc: _homeBloc,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HomeLoading) {
                return SizedBox(
                  height: 100.0,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: ListView(
                        children: [
                          Card(
                            child: Container(
                              height: 200,
                              width: double.infinity,
                            ),
                          )
                        ],
                      )),
                );
              }

              if (state is HomeError) {
                return Center(
                  child: Text("Data tidak bisa di load"),
                );
              }

              if (state is HomeSucces) {
                List<Datum> data = state.data??[];
                List<DataPopulation>? population = state.population;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${data[index].body!}"),
                          subtitle: Image.network(data[index].imgUrl!),
                        ),
                      );
                    });
              }

              return Container();
            },
          )),
      floatingActionButton:
          FloatingActionButton(onPressed: () {
            //_homeBloc.add(GetDataNews());
            Navigator.pushNamed(context, Routes.TRACKING_SCREEN);
          }, child: Icon(Icons.map)),
    );
  }
}
