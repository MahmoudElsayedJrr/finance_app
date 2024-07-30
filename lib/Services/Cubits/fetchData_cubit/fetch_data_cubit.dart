import 'package:bloc/bloc.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());

  List<FinanceModel> financeData = [];
  FetchData() {
    financeData.clear();
    emit(FetchDataLoading());
    try {
      financeData = Hive.box<FinanceModel>('FinanceBox').values.toList();
      emit(FetchDataSuccess());
    } on Exception catch (e) {
      emit(FetchDataFalirue(errMsg: e.toString()));
    }
  }

  void AddData(FinanceModel model) async {
    emit(AddDataLoading());
    try {
      await Hive.box<FinanceModel>('FinanceBox').add(model);
      emit(AddDataSuccess());
      await FetchData();
    } on Exception catch (e) {
      emit(AddDataFalirue(errMsg: e.toString()));
    }
  }
}
