import 'package:hive/hive.dart';
part 'finance_model.g.dart';

@HiveType(typeId: 1)
class FinanceModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  double price;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool isPlus;

  FinanceModel({
    required this.title,
    required this.price,
    required this.date,
    required this.isPlus,
  });

/*   factory FinanceModel.fromJson(json){
     return FinanceModel(title: title, price: price, date: date)
  } */
}
