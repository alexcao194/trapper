// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_snapshot.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsSnapshotAdapter extends TypeAdapter<SettingsSnapshot> {
  @override
  final int typeId = 1;

  @override
  SettingsSnapshot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsSnapshot(
      red: fields[0] as int,
      green: fields[1] as int,
      blue: fields[2] as int,
      themeIndex: fields[3] as int,
      languageCode: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsSnapshot obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.red)
      ..writeByte(1)
      ..write(obj.green)
      ..writeByte(2)
      ..write(obj.blue)
      ..writeByte(3)
      ..write(obj.themeIndex)
      ..writeByte(4)
      ..write(obj.languageCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsSnapshotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
