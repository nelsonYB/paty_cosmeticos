import 'package:flutter/material.dart';
import 'package:paty_cosmeticos/shared/widgets/metric_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Métricas Clave',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MetricCard(
                  title: 'Ventas Diarias',
                  value: '\$ 0,00',
                  icon: Icons.attach_money,
                ),
                MetricCard(
                  title: 'Productos Vendidos',
                  value: '56',
                  icon: Icons.shopping_cart,
                ),
                MetricCard(
                  title: 'Clientes Nuevos',
                  value: '8',
                  icon: Icons.person_add,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}