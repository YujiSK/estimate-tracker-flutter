import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Note: You might need to run `flutter pub add intl` and `flutter pub run intl_utils:generate`
// if you haven't already initialized localization.
// Also ensure `initializeDateFormatting('ja_JP');` is called in your main function.
import 'estimate.dart';

class EstimateDetailPage extends StatelessWidget {
  final Estimate estimate;

  const EstimateDetailPage({super.key, required this.estimate});

  @override
  Widget build(BuildContext context) {
    // Consider initializing date formatting in main.dart or a similar setup location
    // await initializeDateFormatting('ja_JP', null);
    String formattedDate = DateFormat.yMMMMd('ja_JP').format(DateTime.parse(estimate.deliveryDate));

    return Scaffold(
      appBar: AppBar(
        title: const Text('見積の詳細'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: '編集',
            onPressed: () {
              // TODO: Implement navigation to the edit screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditEstimatePage(estimate: estimate)));
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '🧾 基本情報',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.store),
                          title: const Text('サプライヤー'),
                          subtitle: Text(estimate.supplier),
                        ),
                        ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: const Text('商品名'),
                          subtitle: Text(estimate.item),
                        ),
                        ListTile(
                          leading: const Icon(Icons.attach_money),
                          title: const Text('価格'),
                          // Consider using NumberFormat for currency formatting
                          subtitle: Text(
                            '¥${NumberFormat("#,##0").format(estimate.price)}',
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: const Text('納期'),
                          subtitle: Text(formattedDate),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Text(
                              '🗑️ 削除状態',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                estimate.isDeleted ? '削除済み' : '未削除',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      estimate.isDeleted
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                            color:
                                estimate.isDeleted
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                estimate.isDeleted
                                    ? Icons.warning_amber_rounded
                                    : Icons.check_circle_outline_rounded,
                                color:
                                    estimate.isDeleted
                                        ? Colors.red
                                        : Colors.green,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                // Use Expanded to allow text wrapping
                                child: Text(
                                  estimate.isDeleted
                                      ? 'この見積は削除済みとしてマークされています。'
                                      : 'この見積は現在有効です。',
                                  style: TextStyle(
                                    color:
                                        estimate.isDeleted
                                            ? Colors.red.shade800
                                            : Colors.green.shade800,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
