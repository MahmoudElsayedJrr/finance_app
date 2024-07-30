// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinanceModelAdapter extends TypeAdapter<FinanceModel> {
  @override
  final int typeId = 1;

  @override
  FinanceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinanceModel(
      title: fields[0] as String,
      price: fields[1] as double,
      date: fields[2] as DateTime,
      isPlus: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FinanceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.isPlus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinanceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
