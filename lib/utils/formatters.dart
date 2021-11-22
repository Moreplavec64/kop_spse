import 'package:flutter/material.dart';

class Formatters {
  static final Map<String, Color> colorMap = {
    'ROB': Color(0xffffff80),
    'MAT': Color(0xff80b3b3),
    'TSV': Color(0xffffccb3),
    'EKO': Color(0xffe0ff80),
    'SJL': Color(0xffe090ff),
    'RPJ': Color(0xffc0e0ff),
    'PRO': Color(0xff80ffc0),
    'ELK': Color(0xffb3b3b3),
    'SXT': Color(0xffffc0c0),
    'CEC': Color(0xff80c0c0),
    'SIE': Color(0xffffb3b3),
    'DAA': Color(0xff99b380),
    'ANJ': Color(0xffff8080),
    'WIS': Color(0xff80b3cc),
  };

  static Map<String, int> svkMesiacDoCislo = {
    'január': 1,
    'február': 2,
    'marec': 3,
    'apríl': 4,
    'máj': 5,
    'jún': 6,
    'júl': 7,
    'august': 8,
    'september': 9,
    'október': 10,
    'november': 11,
    'december': 12,
  };

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

  static String getDenFromWeekday(int weekday) {
    final days = [
      'Pondelok',
      'Utorok',
      'Streda',
      'Štvrtok',
      'Piatok',
      'Sobota',
      'Nedeľa',
    ];
    return days[weekday - 1];
  }

  static String ddMMMMyy(DateTime datetime) {
    return '${datetime.day}. ${_mesiaceKolkateho[datetime.month]} ${datetime.year}';
  }
}
