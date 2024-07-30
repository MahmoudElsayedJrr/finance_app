import 'package:hive/hive.dart';
part 'finance_model.g.dart';

@HiveType(typeId: 1)
class FinanceModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final bool isPlus;

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
