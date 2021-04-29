enum FilterPeriod {
  all,
  thisWeek,
  lastWeek,
  thisMonth,
}

extension FilterPeriodExtension on FilterPeriod {
  String get description {
    switch (this) {
      case FilterPeriod.all:
        return 'Todas';
      case FilterPeriod.thisWeek:
        return 'Esta semanda';
      case FilterPeriod.lastWeek:
        return 'Semanda passada';
      case FilterPeriod.thisMonth:
        return 'Este mês';
      default:
        return 'Não definido';
    }
  }
}
