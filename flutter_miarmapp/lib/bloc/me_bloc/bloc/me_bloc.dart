import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/models/me_response.dart';
import 'package:flutter_miarmapp/repository/me/me_repository.dart';

part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final MeRepository meRepository;

  MeBloc(this.meRepository) : super(MeInitial()) {
    on<FetchMeEvent>(_meFetched);
  }

  void _meFetched(FetchMeEvent event, Emitter<MeState> emit) async {
    try {
      final me = await meRepository.fetchMe();
      emit(MeFetched(me));
      return;
    } on Exception catch (e) {
      emit(MeFetchedError(e.toString()));
    }
  }
}
