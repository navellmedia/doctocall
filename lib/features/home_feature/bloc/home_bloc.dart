import 'package:doctorcall/features/home_feature/models/population_response.dart';
import 'package:doctorcall/features/home_feature/repositories/home_repository.dart';
import 'package:doctorcall/features/news_feature/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctorcall/features/news_feature/models/news_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetDataNews>(_getDataNews);
  }

  Future _getDataNews(GetDataNews event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    if (event is GetDataNews) {
      try {
        var _data = await HomeRepository.getNewsData();
        var _pupulation =  await HomeRepository.getPopulation();
        emit(HomeSucces(data: _data?.data, population: _pupulation?.dataPopulation));

      } catch (e) {
        emit(HomeError(message: "Gagal mengambil data"));
      }
    }
  }
}
