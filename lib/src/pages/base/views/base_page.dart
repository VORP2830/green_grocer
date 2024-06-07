import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/base/controllers/navigation_controller.dart';
import 'package:green_grocer/src/pages/cart/cart_tab.dart';
import 'package:green_grocer/src/pages/home/views/home_tab.dart';
import 'package:green_grocer/src/pages/orders/orders_tab.dart';
import 'package:green_grocer/src/pages/profile/profile_tab.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final _navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //Impede o scroll da tela
        physics: const NeverScrollableScrollPhysics(),
        controller: _navigationController.pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _navigationController.currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          onTap: (int index) {
            _navigationController.navigatePageView(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
