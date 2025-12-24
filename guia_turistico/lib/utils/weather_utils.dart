import 'package:flutter/material.dart';

String getWeatherDescription(int code) {
  switch (code) {
    case 0:
      return 'Céu limpo';
    case 1:
    case 2:
    case 3:
      return 'Parcialmente nublado';
    case 45:
    case 48:
      return 'Nevoeiro';
    case 51:
    case 53:
    case 55:
      return 'Chuvisco';
    case 61:
    case 63:
    case 65:
      return 'Chuva';
    case 71:
    case 73:
    case 75:
      return 'Neve';
    case 95:
      return 'Trovoada';
    default:
      return 'Desconhecido';
  }
}

IconData getWeatherIcon(int code) {
  switch (code) {
    case 0:
      return Icons.wb_sunny;
    case 1:
    case 2:
    case 3:
      return Icons.cloud;
    case 45:
    case 48:
      return Icons.foggy;
    case 61:
    case 63:
    case 65:
      return Icons.umbrella;
    case 71:
    case 73:
    case 75:
      return Icons.ac_unit;
    case 95:
      return Icons.flash_on;
    default:
      return Icons.help_outline;
  }
}
