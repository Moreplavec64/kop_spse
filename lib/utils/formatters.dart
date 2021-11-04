class Formatters {
  static Map<int, String> _mesiaceKolkateho = {
    1: 'Januára',
    2: 'Februára',
    3: 'Marca',
    4: 'Apríla',
    5: 'Mája',
    6: 'Júna',
    7: 'Júla',
    8: 'Augusta',
    9: 'Septembra',
    10: 'Októbra',
    11: 'Novembra',
    12: 'Decembra',
  };

  static String ddMMMMyy(DateTime datetime) {
    return '${datetime.day}. ${_mesiaceKolkateho[datetime.month]} ${datetime.year}';
  }
}
