class OperableDto {}

class NumberDto implements OperableDto {
  NumberDto(this.numberString);

  String numberString;

  double getNumberValue() {
    return double.parse(numberString);
  }

  void appendDigit(String digit) {
    this.numberString += digit;
  }

  void removeLastDigit() {
    this.numberString = this.numberString.substring(0, numberString.length - 1);
  }

  void appendPeriod() {
    if (numberString.contains('.')) {
      return;
    }

    this.numberString = this.numberString + ".";
  }

  bool isZero() {
    return getNumberValue() == 0;
  }

  @override
  String toString() {
    return numberString;
  }
}

class OperatorDto implements OperableDto {
  OperatorDto(this.operatorType);

  final OperatorType operatorType;

  @override
  String toString() {
    switch (operatorType) {
      case OperatorType.add:
        return '+';
      case OperatorType.subtract:
        return '-';
      case OperatorType.multiply:
        return '×';
      case OperatorType.divide:
        return '÷';
      case OperatorType.power:
        return '^';
      case OperatorType.percent:
        return '%';
      default:
        return '😀';
    }
  }
}

enum OperatorType { add, subtract, multiply, divide, power, percent }
