import 'package:bloc/bloc.dart';
import 'package:finance_application/Services/Models/finance_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());

  List<FinanceModel> financeData = [];
  List<FinanceModel> TodayfinanceData = [];
  double Balance = 0.0;
  double TodayBalance = 0.0;
  FetchData({DateTime? date}) {
    financeData.clear();
    TodayfinanceData.clear();
    emit(FetchDataLoading());
    try {
      financeData = Hive.box<FinanceModel>('FinanceBox').values.toList();
      TodayfinanceData = Hive.box<FinanceModel>('FinanceBox')
          .values
          .where((element) =>
              DateFormat.yMMMEd().format(element.date) ==
              DateFormat.yMMMEd().format(date ?? DateTime.now()))
          .toList();
      Balance = 0.0;
      TodayBalance = 0.0;
      for (var element in financeData) {
        Balance += element.price;
      }
      for (var element in TodayfinanceData) {
        TodayBalance += element.price;
      }
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

/*   List<FinanceModel> financesListByDate = [];
  void FetchDataByDate(DateTime date) {
    financesListByDate.clear();
    emit(FetchDataLoading());
    try {
      financesListByDate = Hive.box<FinanceModel>('FinanceBox')
          .values
          .where((element) => element.date == date)
          .toList();
      emit(FetchDataSuccess());
    } catch (e) {
      emit(FetchDataFalirue(errMsg: e.toString()));
    }
  }*/
}
