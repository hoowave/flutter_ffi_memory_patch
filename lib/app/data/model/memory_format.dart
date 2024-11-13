enum MemoryFormat {
  Byte,
  TwoByte,
  FourByte,
  Hex
}

extension MemoryFormatExtension on MemoryFormat {
  String get displayName {
    switch (this) {
      case MemoryFormat.Byte:
        return 'Byte';
      case MemoryFormat.TwoByte:
        return '2 Byte';
      case MemoryFormat.FourByte:
        return '4 Byte';
      case MemoryFormat.Hex:
        return 'Hex';
    }
  }

  int get size{
    switch (this) {
      case MemoryFormat.Byte:
        return 1;
      case MemoryFormat.TwoByte:
        return 2;
      case MemoryFormat.FourByte:
        return 4;
      case MemoryFormat.Hex:
        return 4;
    }
  }
}