part of 'me_bloc.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

class MeInitial extends MeState {}

class MeFetched extends MeState {
  final MeResponse meResponse;

  const MeFetched(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class MeFetchedError extends MeState {
  final String message;
  const MeFetchedError(this.message);

  @override
  List<Object> get props => [message];
}
