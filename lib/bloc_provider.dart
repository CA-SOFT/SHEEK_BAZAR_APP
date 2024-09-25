import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/config/themes/cubit/themes_cubit.dart';
import 'package:sheek_bazar/features/auth/data/repositories/forget_password_repo.dart';
import 'package:sheek_bazar/features/auth/data/repositories/login_repo.dart';
import 'package:sheek_bazar/features/auth/data/repositories/signUp_repo.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/repositories/add_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/delete_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/update_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/confirm_order_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_order_details_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_orders_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/bloc/supplier_order_bloc.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/cart_repo.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/checkout_repo.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/myAddress_repo.dart';
import 'package:sheek_bazar/features/user/categories/data/repositories/categories_repo.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/repositories/productDetails_repo.dart';
import 'package:sheek_bazar/features/user/home/data/repositories/use_app_repo.dart';
import 'package:sheek_bazar/features/user/laundry/data/repositories/laundry_repo.dart';
import 'package:sheek_bazar/features/user/laundry/presentation/cubit/laundry_cubit.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/collect_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/favorite_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/get_user_info_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/orderDetails_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/orders_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/pay_by_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/updateProfile_repo.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/follow_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/followers_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/getProducts_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/shops_repo.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

import 'Locale/cubit/locale_cubit.dart';
import 'config/internet/cubit/internet_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/user/cart/presentation/cubit/cart_cubit.dart';
import 'features/user/home/data/repositories/home_repo.dart';
import 'injection_container.dart' as di;

import 'features/user/home/presentation/cubit/home_cubit.dart';

MultiBlocProvider blocMultiProvider({required child}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (BuildContext context) => HomeCubit(
          homeRepo: di.sl<HomeRepo>(),
          useAppRepo: di.sl<UseAppRepo>(),
        ),
      ),
      BlocProvider(
        create: (BuildContext context) => AuthCubit(
            logInRepo: di.sl<LogInRepo>(),
            signUpRepo: di.sl<SignUpRepo>(),
            forgetPassswordRepo: di.sl<ForgetPassswordRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => CartCubit(
            myAddressRepo: di.sl<MyAddressRepo>(),
            cartRepo: di.sl<CartRepo>(),
            checkoutRepo: di.sl<CheckoutRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ProfileCubit(
            orderDetailsRepo: di.sl<OrderDetailsRepo>(),
            getUserInfoRepo: di.sl<GetUserInfoRepo>(),
            pointsRepo: di.sl<PointsRepo>(),
            collectPointsRepo: di.sl<CollectPointsRepo>(),
            favoriteRepo: di.sl<FavoriteRepo>(),
            payByPointsRepo: di.sl<PayByPointsRepo>(),
            ordersRepo: di.sl<OrdersRepo>(),
            updateProfileRepo: di.sl<UpdateProfileRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ProductDetailsCubit(
            productDetailsRepo: di.sl<ProductDetailsRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) =>
            AddProductCubit(addProductRepo: di.sl<AddProductRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) =>
            CategoriesCubit(categoriesRepo: di.sl<CategoriesRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => ShopsCubit(
          shopsRepo: di.sl<ShopsRepo>(),
          followRepo: di.sl<FollowRepo>(),
          getProductsRepo: di.sl<GetProductsRepo>(),
          followersRepo: di.sl<FollowersRepo>(),
        ),
      ),
      BlocProvider(
        create: (BuildContext context) => SupplierOrderCubit(
            getSupplierOrders: di.sl<GetSupplierOrdersRepo>(),
            confirmRepo: di.sl<ConfirmRepo>(),
            getSupplierOrderDetailsRepo: di.sl<GetSupplierOrderDetailsRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => LaundryCubit(
          lundryRepo: di.sl<LundryRepo>(),
        ),
      ),
      BlocProvider(
        create: (BuildContext context) => SupplierProfileCubit(
            updateProductRepo: di.sl<UpdateProductRepo>(),
            deleteProductRepo: di.sl<DeleteProductRepo>()),
      ),
      BlocProvider(
        create: (BuildContext context) => LocaleCubit()..getSavedLAnguage(),
      ),
      BlocProvider(
        create: (BuildContext context) => ThemesCubit()..knowMobileMode(),
      ),
      // BlocProvider(
      //   create: (BuildContext context) => InternetCubit()..checkConnection(),
      // ),
    ],
    child: child,
  );
}
