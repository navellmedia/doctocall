part of 'home_bloc.dart';
abstract class HomeState extends Equatable{
  const HomeState();

  @override
  List<Object> get props=> [];
}

class HomeInitial extends HomeState{}

class HomeLoading extends HomeState{}

class HomeSucces extends HomeState{
  List<Datum>? data;
  HomeSucces({this.data});
}

class HomeError extends HomeState{
  final String? message;

  HomeError({this.message});
}