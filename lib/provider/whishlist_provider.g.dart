// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whishlist_provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WhishlistAdapter extends TypeAdapter<Whishlist> {
  @override
  final int typeId = 1;

  @override
  Whishlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Whishlist(
      image: fields[1] as List,
      title: fields[2] as String,
      price: fields[3] as int,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Whishlist obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WhishlistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
