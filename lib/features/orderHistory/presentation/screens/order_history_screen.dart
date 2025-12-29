import 'package:flutter/material.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/shared/custom_snack_bar.dart';
import 'package:hungry/features/orderHistory/data/model/datum.dart';
import 'package:hungry/features/orderHistory/data/repo/order_history_repo.dart';
import 'package:hungry/features/orderHistory/presentation/widgets/order_history_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderHistoryRepo orderHistoryRepo = OrderHistoryRepo();
  List<Datum> ordersList = [];
  bool isLoading = false;
  Future<void> fetchOrdersHistory() async {
    try {
      isLoading = true;
      setState(() {});
      final orderHistoryModel = await orderHistoryRepo.fetchOrderHistory();
      isLoading = false;

      setState(() {
        ordersList = orderHistoryModel.data ?? [];
      });
    } catch (e) {
      if (!mounted) return;
      isLoading = false;
      setState(() {});
      showCustomSnackBar(context, e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrdersHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ordersList.isEmpty
            ? const Center(child: Text('No orders found'))
            : ListView.builder(
                itemBuilder: (context, index) {
                  final order = ordersList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                      left: 16,
                      right: 16,
                    ),
                    child: OrderHistoryItem(order: order),
                  );
                },
                itemCount: ordersList.length,
              ),
      ),
    );
  }
}
