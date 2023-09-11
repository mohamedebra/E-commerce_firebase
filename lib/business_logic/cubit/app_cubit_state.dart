part of 'app_cubit_bloc.dart';

@immutable
abstract class BuyState {}

class BuyInitial extends BuyState {}
class BuyError extends BuyState{
  var error;
  BuyError(this.error);

}
class BuyLoaded extends BuyState {}
class BuyIsLoading extends BuyState {}
class BuyIsColor extends BuyState {}
class BuyScsuss extends BuyState {}
class BuyErrorSginIn extends BuyState{
  var error;
  BuyErrorSginIn(this.error);

}
class BuyLoadedSginIn extends BuyState {}
class BuyScsussSginIn extends BuyState {}
class BuyAddProduct extends BuyState {}
class BuyAddProductOrder extends BuyState {}
class AddProductOrder extends BuyState {}
class AddProductItmes extends BuyState {}
class LoadProdact extends BuyState {}
class LoadProdactSucsess extends BuyState {}
class ErorrProduct extends BuyState {}
class DeleteProduct extends BuyState {}
class DeleteProducts extends BuyState {}
class ChangeBottonNav extends BuyState {}
class ChangeCheckbox extends BuyState {}
class DeleteProductItems extends BuyState {}
class EditMenuItems extends BuyState {}
class AppImageSucsessState extends BuyState {}
class AppImageErorrState extends BuyState {}
