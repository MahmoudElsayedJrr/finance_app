part of 'fetch_data_cubit.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}

final class FetchDataLoading extends FetchDataState {}

final class FetchDataSuccess extends FetchDataState {}

final class FetchDataFalirue extends FetchDataState {
  final String errMsg;

  FetchDataFalirue({required this.errMsg});
}

final class AddDataLoading extends FetchDataState {}

final class AddDataSuccess extends FetchDataState {}

final class AddDataFalirue extends FetchDataState {
  final String errMsg;

  AddDataFalirue({required this.errMsg});
}

final class RemoveDataLoading extends FetchDataState {}

final class RemoveDataSuccess extends FetchDataState {}

final class RemoveDataFalirue extends FetchDataState {
  final String errMsg;

  RemoveDataFalirue({required this.errMsg});
}
