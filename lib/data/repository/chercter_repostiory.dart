import 'package:api/data/models/character.dart';
import 'package:api/data/web_services/character_api.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];

  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }
}


class AdminMode extends ChangeNotifier
{
  bool isAdmin =false ;
  changeIsAdmin(bool value )
  {
    isAdmin=value;
    notifyListeners();
  }
}
class ModelHud extends ChangeNotifier
{
  bool isLoading =false;

  changeisLoading(bool value)
  {
    isLoading=value;
    notifyListeners();
  }
}


class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  // Future<List<Character>> getAllCharacters() async {
  //   final characters = await charactersWebServices.getAllCharacters();
  //   return characters.map((character) => Character.fromJson(character)).toList();
  // }
  //
  // Future<List<Quote>> getCharacterQuotes(String charName) async {
  //   final quotes = await charactersWebServices.getCharacterQuotes(charName);
  //   return quotes.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  // }



}