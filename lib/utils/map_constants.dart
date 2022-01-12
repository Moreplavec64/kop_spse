import 'package:flutter/material.dart';

Map<String, Map<String, int>> edges = {
  //*PRIZEMIE HLAVNEJ BUDOVY

  'B0VYCHOD': {'TELOCVICNE': 11, 'B0TOPCHODBA': 5},
  'B0TOPCHODBA': {'TELOCVICNE': 12, 'B0VYCHOD': 5, 'B0WCZ': 12, 'B0WCM': 20},
  'TELOCVICNE': {'B0TOPCHODBA': 12, 'B0VYCHOD': 11},
  'B0WCM': {'B0TOPCHODBA': 20, 'ATRIUM_VCHOD_CHODBA': 18},
  'ATRIUM_VCHOD_CHODBA': {'B0WCM': 18, 'ATRIUM': 25, 'D0FPRIHCH': 42},
  'ATRIUM': {'ATRIUM_VCHOD_CHODBA': 25},
  'D0FPRIHCH': {'ATRIUM_VCHOD_CHODBA': 42, 'F006/F004': 7, 'D0F_SCHODY': 4},
  'F006/F004': {'D0FPRIHCH': 7, 'F007': 9},
  'F007': {'F006/F004': 9},
  'D0F_SCHODY': {
    'D0FPRIHCH': 4,
    'JEDALEN_SCHODY_BOTTOM': 11,
    'JEDALEN_CHODBA': 18,
    'D0HUB': 30,
    'D0HC_SPOD': 37,
  },
  'D0HC_SPOD': {'D0KCH': 6, 'D0WCZ': 12, 'D0HUB': 11, 'D0F_SCHODY': 37},
  'D0HUB': {
    'D0F_SCHODY': 30,
    'ZELSAL/JED': 15,
    'D0KCH': 9,
    'D0HC_SPOD': 11,
    'JEDALEN_CHODBA': 16,
    'JEDALEN_VCHOD': 21,
  },
  'JEDALEN_CHODBA': {
    'D0HUB': 16,
    'D0F_SCHODY': 18,
    'JEDALEN_SCHODY_BOTTOM': 14,
    'JEDALEN_VCHOD': 10,
    'ZELSAL/JED': 18,
  },
  'ZELSAL/JED': {'D0HUB': 15, 'JEDALEN_CHODBA': 18, 'JEDALEN_VCHOD': 14},
  'JEDALEN_VCHOD': {
    'ZELSAL/JED': 14,
    'JEDALEN_CHODBA': 10,
    'D0HUB': 21,
    'JEDALEN1': 61
  },
  'JEDALEN1': {'JEDALEN_VCHOD': 61, 'JEDALEN2': 30},
  'JEDALEN2': {'JEDALEN1': 30, 'KUCHYNA1': 26},
  'KUCHYNA1': {'JEDALEN2': 26, 'VJCHODBA': 10},
  'VJCHODBA': {'KUCHYNA1': 10, 'VJ': 10},
  'VJ': {'VJCHODBA': 10},
  'JEDALEN_SCHODY_BOTTOM': {
    'JEDALEN_SCHODY_TOP': 33,
    'JEDALEN_CHODBA': 14,
    'D0F_SCHODY': 11,
  },
  'D0KCH': {'D0HUB': 9, 'D0HC_SPOD': 6, 'D0WCM': 19, 'D010': 15},
  'D0WCM': {'D0KCH': 19, 'D0VYCHOD': 12},
  'D0VYCHOD': {'D0WCM': 12},
  'D010': {'D0KCH': 15, 'D011': 10},
  'D011': {'D012': 10, 'D010': 10},
  'D012': {'D013-14/Riaditel': 10, 'D011': 10},
  'D013-14/Riaditel': {'D012': 10},
  'D0WCZ': {'D0HC_SPOD': 12, 'D015': 4},
  'D015': {'D002': 3, 'D0WCZ': 4},
  'D002': {'D015': 3, 'D001': 13},
  'D001': {'C001': 14, 'D002': 13},
  'C001': {'D001': 14, 'C002': 14},
  'C002': {'C0KCH': 18, 'C001': 14},
  'C0KCH': {
    'C002': 18,
    'C0WCZ': 19,
    'C0CH': 5,
    'ATRIUM_SCHODY_BOTTOM': 33,
    'C0CH_SCHODY': 33
  },
  'C0WCZ': {'C0KCH': 19, 'C0VYCHOD': 12},
  'C0VYCHOD': {'C0WCZ': 12},
  'C0WCM': {'C0CH': 13, 'C008': 8},
  'C0CH': {'C0WCM': 13, 'C0KCH': 5, 'C0CH_SCHODY': 32},
  'C008': {'C009': 14, 'C0WCM': 8},
  'C009': {'C008': 14, 'C010/C011': 18},
  'C010/C011': {'C009': 18},
  'ATRIUM_SCHODY_BOTTOM': {
    'C0KCH': 33,
    'ATRIUM_SCHODY_TOP': 37,
    'C0CH_SCHODY': 10,
    '1ATRIUM_SCHODY_END': 1,
  },
  'C0CH_SCHODY': {
    'C0KCH': 33,
    'ATRIUM_SCHODY_BOTTOM': 10,
    'C0CH': 32,
    'A0WCM': 64
  },
  'A0WCM': {'C0CH_SCHODY': 64, 'A0KCH': 24, 'A0CH': 23},
  'A0CH': {'A0WCZ': 12, 'A0KCH': 5, 'A0WCM': 23},
  'A0WCZ': {'A0CH': 12, 'A008': 8},
  'A008': {'A009': 18, 'A0WCZ': 8},
  'A009': {'A008': 18, 'A010/A011': 12},
  'A010/A011': {'A009': 12},
  'A0KCH': {'A0CH': 5, 'A0WCM': 24, 'A0VYCHOD': 4, 'A002': 17},
  'A0VYCHOD': {'A0KCH': 4},
  'A002': {'A0KCH': 17, 'A001': 14},
  'A001': {'B001': 14, 'A002': 14},
  'B001': {'A001': 14, 'B002': 12},
  'B002': {'B0WCZ': 7, 'B001': 12},
  'B0WCZ': {'B002': 7, 'B0TOPCHODBA': 12},
  'JEDALEN_SCHODY_TOP': {'JEDALEN_SCHODY_BOTTOM': 33, 'ZB_SCHODY_DOLE_END': 1},
  'ATRIUM_SCHODY_TOP': {'ATRIUM_SCHODY_BOTTOM': 33, '1ATRIUM_SCHODY_START': 1},

  //*PRVE PODCHODIE HLAVNEJ BUDOVY

  'B109/B110': {'B108': 13},
  'B108': {'B109/B110': 13, 'B107': 8},
  'B107': {'B106': 11, 'B108': 8},
  'B106': {'B107': 11, 'B1_ZBOROVNA_ROH': 11},
  'B1_ZBOROVNA_ROH': {
    'B106': 11,
    'B1_HUBCH': 12,
    '1ZBOROVNA_CHODBA': 19,
    'F105': 17,
    '1F_CHODBA': 23,
    'B1WCM': 16,
    'B1HC_ROH': 29,
  },
  '1ZBOROVNA_CHODBA': {
    '1ZBOROVNA_VCHOD2': 3,
    'B1_ZBOROVNA_ROH': 19,
    'ZB_SCHODY_DOLE_START': 5,
    '1F_CHODBA': 12,
    'B1_HUBCH': 24,
    'F105': 14,
  },
  'B1_HUBCH': {
    'B1_ZBOROVNA_ROH': 12,
    'F105': 12,
    'B1WCM': 9,
    '1ZBOROVNA_CHODBA': 24
  },
  'F105': {
    'B1_HUBCH': 12,
    'B1_ZBOROVNA_ROH': 15,
    '1F_CHODBA': 6,
    '1ZBOROVNA_CHODBA': 14
  },
  'B1WCM': {'B1_ZBOROVNA_ROH': 16, 'B1_HUBCH': 9, 'B1HC_ROH': 16},
  '1F_CHODBA': {'1ZBOROVNA_CHODBA': 12, 'F105': 6, 'F106': 6},
  'B1HC_ROH': {'B1_ZBOROVNA_ROH': 28, 'B1WCM': 16, 'B1WCZ': 13},
  'B1WCZ': {'B1HC_ROH': 16, 'B102': 7},
  'B102': {'B101': 13, 'B1WCZ': 7},
  'B101': {'B102': 13, 'A101': 16},
  'A101': {'A102': 16, 'B101': 16},
  'A102': {'A1KCH2': 13, 'A101': 16},
  'A1KCH2': {'A102': 13, 'A1KCH': 10, 'A1WCM': 26, '1ATRIUM_SCHODY_START': 45},
  'A1KCH': {'A1KCH2': 10, 'A1WCM': 23, 'A1WCZ': 12},
  'A1WCZ': {'A1KCH': 12, 'A106': 8},
  'A106': {'A107': 13, 'A1WCZ': 8},
  'A107': {'A106': 13, 'A108/A109': 16},
  'A108/A109': {'A107': 16},
  'A1WCM': {
    'A1KCH': 23,
    'A1KCH2': 26,
    '1ATRIUM_SCHODY_START': 26,
    '1ATRIUM_SCHODY_CHODBA': 23
  },
  '1ATRIUM_SCHODY_START': {
    'ATRIUM_SCHODY_TOP': 1,
    '1ATRIUM_SCHODY_END': 37,
    'A1WCM': 26,
    'A1KCH2': 45,
    '1ATRIUM_SCHODY_CHODBA': 10
  },
  '1ATRIUM_SCHODY_END': {'1ATRIUM_SCHODY_START': 37, 'ATRIUM_SCHODY_BOTTOM': 1},
  '1ATRIUM_SCHODY_CHODBA': {
    '1ATRIUM_SCHODY_START': 10,
    'A1WCM': 23,
    'C1032': 75
  },
  'C1032': {'1ATRIUM_SCHODY_CHODBA': 75, 'C1031': 10, 'C1WCM': 8},
  'C1WCM': {'C1032': 8, 'C1WCZ': 4},
  'C1WCZ': {'C106': 8, 'C1WCM': 4},
  'C106': {'C1WCZ': 8, 'C107': 12},
  'C107': {'C108/C109': 17, 'C106': 12},
  'C108/C109': {'C107': 17},
  'C1031': {'C1032': 10, 'C102': 12},
  'C102': {'C101': 14, 'C1031': 12},
  'C101': {'C102': 14, 'D101': 14},
  'D101': {'D102': 13, 'C101': 14},
  'D102': {'D101': 13, 'D1WCZ': 7},
  'D1WCZ': {'D1WCM': 5, 'D102': 7},
  'D1WCM': {'D1WCZ': 5, 'D1502': 8},
  'D1502': {'D1WCM': 8, 'F101': 11, 'D1501': 10, 'D1UCITELSKEWC': 16},
  'D1501': {
    'F102': 26,
    'F101': 15,
    'D1502': 10,
    'D1UCITELSKEWC': 12,
    'D106': 13
  },
  'F101': {
    'D1502': 11,
    'D1501': 15,
    'D1UCITELSKEWC': 11,
    'D1SCHODY_ZBOROVNA': 22,
    'F102': 13,
    'ZB_SCHODY_HORE_START': 26
  },
  'F102': {
    'F101': 13,
    'D1501': 26,
    'D1UCITELSKEWC': 16,
    'D1SCHODY_ZBOROVNA': 12,
    'ZB_SCHODY_HORE_START': 15,
    'D1HC_0': 7,
  },
  'D1HC_0': {
    'F102': 7,
    'F103': 6,
    'ZB_SCHODY_HORE_START': 9,
    'D1SCHODY_ZBOROVNA': 10,
    'D1UCITELSKEWC': 22,
  },
  'F103': {
    'D1HC_0': 6,
    'ZB_SCHODY_HORE_START': 7,
    'D1SCHODY_ZBOROVNA': 12,
    'F106': 31
  },
  'F106': {'F103': 31, '1F_CHODBA': 6},
  'D1SCHODY_ZBOROVNA': {
    '1ZBOROVNA_VCHOD1': 5,
    'ZB_SCHODY_HORE_START': 7,
    'F103': 12,
    'D1HC_0': 10,
    'F102': 12,
    'F101': 22,
    'D1UCITELSKEWC': 18
  },
  'D1UCITELSKEWC': {
    'D1501': 12,
    'D1502': 16,
    'F101': 11,
    'F102': 16,
    'D1HC_0': 22,
    'D1SCHODY_ZBOROVNA': 18
  },
  'D106': {'D1501': 13, 'D107/D108': 16},
  'D107/D108': {'D106': 16},
  '1ZBOROVNA_VCHOD1': {
    'D1SCHODY_ZBOROVNA': 5,
    'F108': 16,
    'ZBOROVNA_STRED': 128,
  },
  'F108': {'1ZBOROVNA_VCHOD1': 16, 'ZBOROVNA_STRED': 32},
  'ZBOROVNA_STRED': {
    '1ZBOROVNA_VCHOD1': 128,
    'F108': 32,
    '1ZBOROVNA_VCHOD2': 120
  },
  '1ZBOROVNA_VCHOD2': {'1ZBOROVNA_CHODBA': 3, 'ZBOROVNA_STRED': 120},
  'ZB_SCHODY_DOLE_START': {'1ZBOROVNA_CHODBA': 5, 'ZB_SCHODY_DOLE_END': 32},
  'ZB_SCHODY_DOLE_END': {'ZB_SCHODY_DOLE_START': 32, 'JEDALEN_SCHODY_TOP': 1},
  'ZB_SCHODY_HORE_START': {
    'ZB_SCHODY_HORE_END': 32,
    'D1SCHODY_ZBOROVNA': 7,
    'F101': 26,
    'F102': 15,
    'D1HC_0': 15,
    'F103': 7
  },
  'ZB_SCHODY_HORE_END': {'ZB_SCHODY_HORE_START': 32, 'DRUHE_SCHODY_BOTTOM': 1},
  //TODO prerobit prepojenie schodov atrium
  //TODO pridat waypoint HC pri rou zeleneho salonika a jedalne
  //*DRUHE POSCHODIE HLAVNEJ BUDOVY
  'DRUHE_SCHODY_BOTTOM': {'ZB_SCHODY_HORE_END': 1, 'DRUHE_SCHODY_TOP': 52},
  'DRUHE_SCHODY_TOP': {'DRUHE_SCHODY_BOTTOM': 52, 'F201': 17},
  'F201': {'F206': 11, 'DRUHE_SCHODY_TOP': 17},
  'F206': {'F201': 11, 'F203': 8},
  'F203': {'F204': 60, 'F206': 8},
  'F204': {'F203': 60, 'F204_CHODBA': 24},
  'F204_CHODBA': {'F205': 19, 'F204': 24},
  'F205': {'F204_CHODBA': 19},
};

Map<String, Map<String, Offset>> suradniceWaypointov = {
  //*PRIZEMIE HLAVNEJ BUDOVY
  'HBP0': {
    'B0VYCHOD': Offset(177, 98.5),
    'B0TOPCHODBA': Offset(172.5, 98.5),
    'TELOCVICNE': Offset(177, 88),
    'B0WCM': Offset(153, 98.5),
    'ATRIUM_VCHOD_CHODBA': Offset(135, 98.5),
    'ATRIUM': Offset(135, 123),
    'D0FPRIHCH': Offset(93, 98.5),
    'F006/F004': Offset(93, 105.5),
    'F007': Offset(84, 105.5),
    'D0F_SCHODY': Offset(89, 98.5),
    'D0HC_SPOD': Offset(52.5, 98.5),
    'D0HUB': Offset(61, 93),
    'JEDALEN_CHODBA': Offset(75, 88),
    'ZELSAL/JED': Offset(61, 78),
    'JEDALEN_VCHOD': Offset(47, 78),
    'JEDALEN1': Offset(136, 78),
    'JEDALEN2': Offset(136, 48),
    'KUCHYNA1': Offset(162, 48),
    'VJCHODBA': Offset(162, 38),
    'VJ': Offset(172, 38),
    'JEDALEN_SCHODY_BOTTOM': Offset(89, 88),
    'D0KCH': Offset(52.5, 93),
    'D0WCM': Offset(33.5, 93),
    'D0VYCHOD': Offset(21, 93),
    'D010': Offset(52.5, 78.5),
    'D011': Offset(52.5, 68.5),
    'D012': Offset(52.5, 58.5),
    'D013-14/Riaditel': Offset(52.5, 48.5),
    'D0WCZ': Offset(52.5, 110.5),
    'D015': Offset(52.5, 115),
    'D002': Offset(52.5, 118),
    'D001': Offset(52.5, 130.5),
    'C001': Offset(52.5, 145.5),
    'C002': Offset(52.5, 160.5),
    'C0KCH': Offset(52.5, 178),
    'C0WCZ': Offset(33.5, 178),
    'C0VYCHOD': Offset(21, 178),
    'C0WCM': Offset(52.5, 195.5),
    'C0CH': Offset(52.5, 183),
    'C008': Offset(52.5, 203),
    'C009': Offset(52.5, 216.5),
    'C010/C011': Offset(52.5, 234),
    'ATRIUM_SCHODY_BOTTOM': Offset(85, 173),
    'C0CH_SCHODY': Offset(85, 183),
    'A0WCM': Offset(149.5, 183),
    'A0CH': Offset(172.5, 183),
    'A0WCZ': Offset(172.5, 195.5),
    'A008': Offset(172.5, 203),
    'A009': Offset(172.5, 221.5),
    'A010/A011': Offset(172.5, 233.5),
    'A0KCH': Offset(172.5, 178),
    'A0VYCHOD': Offset(177, 178),
    'A002': Offset(172.5, 160.5),
    'A001': Offset(172.5, 145.5),
    'B001': Offset(172.5, 130.5),
    'B002': Offset(172.5, 118),
    'B0WCZ': Offset(172.5, 110.5),
    'JEDALEN_SCHODY_TOP': Offset(122, 88),
    'ATRIUM_SCHODY_TOP': Offset(122, 173),
  },

  //*PRVE PODCHODIE HLAVNEJ BUDOVY
  'HBP1': {
    'B109/B110': Offset(146.5, 42.5),
    'B108': Offset(146.5, 54.5),
    'B107': Offset(146.5, 62.5),
    'B106': Offset(146.5, 74.5),
    'B1_ZBOROVNA_ROH': Offset(146.5, 86),
    '1ZBOROVNA_CHODBA': Offset(127, 86),
    'B1_HUBCH': Offset(146.5, 98),
    'F105': Offset(134, 98),
    'B1WCM': Offset(156, 98),
    '1F_CHODBA': Offset(127, 98),
    'B1HC_ROH': Offset(172.5, 98),
    'B1WCZ': Offset(172.5, 110.5),
    'B102': Offset(172.5, 118),
    'B101': Offset(172.5, 130.5),
    'A101': Offset(172.5, 145.5),
    'A102': Offset(172.5, 160.5),
    'A1KCH2': Offset(172.5, 173),
    'A1KCH': Offset(172.5, 183),
    'A1WCZ': Offset(172.5, 195.5),
    'A106': Offset(172.5, 202.5),
    'A107': Offset(172.5, 216),
    'A108/A109': Offset(172.5, 232),
    'A1WCM': Offset(149.5, 183),
    '1ATRIUM_SCHODY_START': Offset(127, 173),
    '1ATRIUM_SCHODY_END': Offset(90, 173),
    '1ATRIUM_SCHODY_CHODBA': Offset(127, 183),
    'C1032': Offset(52.5, 183),
    'C1WCM': Offset(52.5, 190.5),
    'C1WCZ': Offset(52.5, 195.5),
    'C106': Offset(52.5, 203),
    'C107': Offset(52.5, 215.5),
    'C108/C109': Offset(52.5, 232),
    'C1031': Offset(52.5, 173),
    'C102': Offset(52.5, 160.5),
    'C101': Offset(52.5, 145.5),
    'D101': Offset(52.5, 130.5),
    'D102': Offset(52.5, 118),
    'D1WCZ': Offset(52.5, 110.5),
    'D1WCM': Offset(52.5, 105.5),
    'D1502': Offset(52.5, 98),
    'D1501': Offset(52.5, 88),
    'F101': Offset(63.5, 98),
    'F102': Offset(76.5, 98),
    'D1HC_0': Offset(83, 98),
    'F103': Offset(89, 98),
    'F106': Offset(120, 98),
    'D1SCHODY_ZBOROVNA': Offset(83, 88),
    'D1UCITELSKEWC': Offset(64.17, 88),
    'D106': Offset(52.5, 74.5),
    'D107/D108': Offset(52.5, 57.5),
    '1ZBOROVNA_VCHOD1': Offset(83, 83),
    'F108': Offset(78, 69),
    'ZBOROVNA_STRED': Offset(109.5, 75),
    '1ZBOROVNA_VCHOD2': Offset(127, 83),
    'ZB_SCHODY_DOLE_START': Offset(122, 86),
    'ZB_SCHODY_DOLE_END': Offset(89, 86),
    'ZB_SCHODY_HORE_START': Offset(89, 91),
    'ZB_SCHODY_HORE_END': Offset(122, 91),
  }
  //*DRUHE POSCHODIE HLAVNEJ BUDOVY
  ,
  'HBP2': {
    'DRUHE_SCHODY_BOTTOM': Offset(77, 137),
    'DRUHE_SCHODY_TOP': Offset(128.62, 137),
    'F201': Offset(145, 137),
    'F206': Offset(145, 148),
    'F203': Offset(145, 156),
    'F204': Offset(85, 156),
    'F204_CHODBA': Offset(61, 156),
    'F205': Offset(61, 137),
  }
};