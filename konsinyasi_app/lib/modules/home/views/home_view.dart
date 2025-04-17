import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../themes/app_theme.dart';
import '../../../app/controllers/home_controller.dart';
import '../../../widgets/app_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.menu, color: AppTheme.primaryColor),
                      onPressed: () {
                        controller.openDrawer();
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined,
                              color: AppTheme.primaryColor),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: const NetworkImage(
                            'https://via.placeholder.com/150',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: -10,
                        bottom: -10,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  controller.userName.value,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                )),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                                  controller.userRole.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                )),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                                  'WA: ${controller.whatsapp.value}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildMenuCard(
                        icon: Icons.store,
                        title: 'Data\nPenjualan',
                        onTap: controller.navigateToSales,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMenuCard(
                        icon: Icons.inventory,
                        title: 'Stok\nBarang',
                        onTap: controller.navigateToInventory,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMenuCard(
                        icon: Icons.shopping_cart,
                        title: 'Data\nPembelian',
                        onTap: controller.navigateToPurchase,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Statistik',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Obx(() => BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 20,
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() <
                                          controller.statistics.length) {
                                        return Text(
                                          controller.statistics[value.toInt()]
                                              ['month'],
                                          style: const TextStyle(fontSize: 12),
                                        );
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: controller.statistics
                                  .asMap()
                                  .entries
                                  .map((entry) => _generateBarGroup(
                                        entry.key,
                                        entry.value['value'].toDouble(),
                                      ))
                                  .toList(),
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          sections: [
                            PieChartSectionData(
                              color: Colors.blue,
                              value: 75,
                              radius: 50,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: 25,
                              radius: 50,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}
