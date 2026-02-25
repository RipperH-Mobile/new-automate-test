import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';

class SubscriptionListScreen extends GetView<SubscriptionController> {
  const SubscriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
      ),
      body: Column(
        children: [
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('${product.formattedPrice}/${product.period} \n'
                      '(${product.productId})'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      controller.subscribe(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          Center(
            child: ElevatedButton(
              onPressed: controller.handleIosManageSubscription,
              child: const Text('Cancel'),
            ),
          )
        ],
      ),
    );
  }
}
