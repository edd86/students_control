class DateFunctions {
  static String literalDate(DateTime date) {
    return '${literalWeekDay(date.weekday)}, ${date.day} de ${literalMonth(date.month)} de ${date.year}';
  }

  static String literalWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Domingo';
    }
  }

  static String literalMonth(int month) {
    switch (month) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return 'Diciembre';
    }
  }

  static String periodOfDay(DateTime date) {
    final hour = date.hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  static String academicTerm(DateTime date) {
    final year = date.year;
    final month = date.month;
    if (month < 7) {
      return '1/$year';
    } else {
      return '2/$year';
    }
  }
}
