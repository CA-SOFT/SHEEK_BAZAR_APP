import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheek_bazar/Locale/app_localization.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/bloc/supplier_order_bloc.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/widgets/order_card_widget.dart';

class SupplierOrderScren extends StatefulWidget {
  const SupplierOrderScren({super.key});

  @override
  State<SupplierOrderScren> createState() => _SupplierOrderScrenState();
}

class _SupplierOrderScrenState extends State<SupplierOrderScren> {
  @override
  void initState() {
    super.initState();
    context.read<SupplierOrderCubit>().getOrders(context);
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<SupplierOrderCubit>().clearOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SupplierOrderCubit, SupplierOrderState>(
        builder: (context, state) {
          return state.loadingOrders
              ? const Center(child: CircularProgressIndicator())
              : state.orders == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty.png"),
                        Center(
                          child: Text(
                            "no_orders".tr(context),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : state.orders!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/empty.png"),
                            Center(
                              child: Text(
                                "no_orders".tr(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: state.orders!.length,
                          itemBuilder: (context, index) {
                            return OrderSupplierCard(
                              order: state.orders![index],
                            );
                          },
                        );
        },
      ),
    );
  }
}
