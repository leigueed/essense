import 'package:flutter/material.dart';

class AppConstants {
  static const List<String> emocoes = [
    'Poderosa',
    'Serena',
    'Sedutora',
    'Nostálgica',
    'Aventureira',
    'Misteriosa',
  ];

  static const Map<String, List<String>> perguntas = {
    'lugar': ['Praia', 'Floresta', 'Cidade', 'Biblioteca', 'Montanha'],
    'elemento': ['Fogo', 'Água', 'Terra', 'Ar'],
    'cor': ['Dourado', 'Azul', 'Verde', 'Vermelho', 'Preto', 'Branco'],
  };

  static IconData getIcon(String chave) {
    switch (chave) {
      case 'Poderoso':
        return Icons.local_fire_department;
      case 'Serena':
        return Icons.nightlight_round;
      case 'Sedutora':
        return Icons.favorite;
      case 'Nostálgica':
        return Icons.history;
      case 'Aventureira':
        return Icons.explore;
      case 'Misteriosa':
        return Icons.visibility_off;
      case 'Praia':
        return Icons.beach_access;
      case 'Floresta':
        return Icons.forest;
      case 'Cidade':
        return Icons.location_city;
      case 'Biblioteca':
        return Icons.menu_book;
      case 'Montanha':
        return Icons.terrain;
      case 'Fogo':
        return Icons.whatshot;
      case 'Água':
        return Icons.water_drop;
      case 'Terra':
        return Icons.public;
      case 'Ar':
        return Icons.air;
      case 'Dourado':
        return Icons.wb_sunny;
      case 'Azul':
        return Icons.circle;
      case 'Verde':
        return Icons.eco;
      case 'Vermelho':
        return Icons.favorite;
      case 'Preto':
        return Icons.contrast;
      case 'Branco':
        return Icons.brightness_5;

      default:
        return Icons.circle;
    }
  }
}
