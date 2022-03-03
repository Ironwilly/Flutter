part of 'me_bloc.dart';

abstract class MeEvent extends Equatable {
  const MeEvent();

  @override
  List<Object> get props => [];
}

class FetchMeEvent extends MeEvent {
  const FetchMeEvent();
  @override
  List<Object> get props => [];
}
