part of 'shop_app_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ConverteThemeStatus extends ShopState {}

class ToggleBottomNavbarStatus extends ShopState {}

class GetDataHomeSuccessStatus extends ShopState {}

class GetDataHomeErrorStatus extends ShopState {}

class ChangeFacoriteSuccessStatus extends ShopState {}

class ChangeFacoriteErrorStatus extends ShopState {}

class GetDataFavoriteLoadingStatus extends ShopState {}

class GetDataFavoriteSuccessStatus extends ShopState {}

class GetDataFavoriteErrorStatus extends ShopState {}

class GetDataCategorySuccessStatus extends ShopState {}

class GetDataCategoryErrorStatus extends ShopState {}

class GetDataProfileSuccessStatus extends ShopState {
  final ProfileModel? profileModel;

  GetDataProfileSuccessStatus({this.profileModel});
}

class GetDataProfileErrorStatus extends ShopState {}

class GetDataUpdateProfileSuccessStatus extends ShopState {
  final UpdateProfileModel? updateprofileModel;

  GetDataUpdateProfileSuccessStatus({this.updateprofileModel});
}

class GetDataUpdateProfileErrorStatus extends ShopState {}