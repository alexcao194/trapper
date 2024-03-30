// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      name: fields[0] as String?,
      email: fields[1] as String?,
      photoUrl: fields[2] as String?,
      gender: fields[3] as bool?,
      birthDate: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.birthDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
