import 'package:shared_preferences/shared_preferences.dart';

class FavoritosService {
  static const String _key = 'favoritos_ids';

  /// Obter IDs favoritos
  static Future<List<int>> getFavoritosIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key)?.map(int.parse).toList() ?? [];
  }

  /// Verificar se é favorito
  static Future<bool> isFavorito(int id) async {
    final ids = await getFavoritosIds();
    return ids.contains(id);
  }

  /// Adicionar ou remover favorito
  static Future<void> toggleFavorito(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final ids = await getFavoritosIds();

    if (ids.contains(id)) {
      ids.remove(id);
    } else {
      ids.add(id);
    }

    prefs.setStringList(
      _key,
      ids.map((e) => e.toString()).toList(),
    );
  }
}
