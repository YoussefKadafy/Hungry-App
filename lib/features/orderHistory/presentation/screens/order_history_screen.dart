import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/features/orderHistory/data/model/datum.dart';
import 'package:hungry/features/orderHistory/data/repo/order_history_repo.dart';
import 'package:hungry/features/orderHistory/presentation/cubit/order_history_cubit.dart';
import 'package:hungry/features/orderHistory/presentation/cubit/order_history_states.dart';
import 'package:hungry/features/orderHistory/presentation/widgets/order_history_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderHistoryCubit>().fetchOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<OrderHistoryCubit, OrderHistoryStates>(
          builder: (context, state) {
            if (state is OrderHistorySuccess) {
              final itemsList = state.orderHistoryModel.data ?? [];

              return ListView.builder(
                itemBuilder: (context, index) {
                  final item = itemsList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                      left: 16,
                      right: 16,
                    ),
                    child: OrderHistoryItem(order: item),
                  );
                },
                itemCount: itemsList.length,
              );
            }

            if (state is OrderHistoryError) {
              return Center(
                child: CustomText(text: state.message, fontSize: 24),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
