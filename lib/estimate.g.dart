// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EstimateAdapter extends TypeAdapter<Estimate> {
  @override
  final int typeId = 0;

  @override
  Estimate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Estimate(
      supplier: fields[0] as String,
      item: fields[1] as String,
      price: fields[2] as int,
      deliveryDate: fields[3] as String,
      isDeleted: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Estimate obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.supplier)
      ..writeByte(1)
      ..write(obj.item)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.deliveryDate)
      ..writeByte(4)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstimateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
