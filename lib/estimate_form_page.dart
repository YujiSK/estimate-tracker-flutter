import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'estimate.dart';

class EstimateFormPage extends StatefulWidget {
  const EstimateFormPage({super.key});

  @override
  EstimateFormPageState createState() => EstimateFormPageState();
}

class EstimateFormPageState extends State<EstimateFormPage> {
  List<Estimate> estimates = [];
  List<Estimate> filteredEstimates = [];
  
  bool showDeleted = false; // falseなら通常モード、trueなら削除済み一覧

  final _supplierController = TextEditingController();
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  final _searchController = TextEditingController();

  String _sortBy = 'None';

  late Box<Estimate> estimateBox;

  @override
  void initState() {
    super.initState();
    estimateBox = Hive.box<Estimate>('estimates');
    _loadEstimates();
    _searchController.addListener(_filterEstimates);
  }

  void _loadEstimates() {
    setState(() {
      estimates = estimateBox.values.toList();
      _filterEstimates();
    });
  }

  void _addEstimate() {
    if (_supplierController.text.isNotEmpty &&
        _itemController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _dateController.text.isNotEmpty) {
      final newEstimate = Estimate(
        supplier: _supplierController.text,
        item: _itemController.text,
        price: int.parse(_priceController.text),
        deliveryDate: _dateController.text,
      );
      estimateBox.add(newEstimate);
      _supplierController.clear();
      _itemController.clear();
      _priceController.clear();
      _dateController.clear();
      _loadEstimates(); // 再読み込み
    }
  }

  void _sortEstimates() {
    if (_sortBy == 'Price') {
      filteredEstimates.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Date') {
      filteredEstimates.sort(
        (a, b) => a.deliveryDate.compareTo(b.deliveryDate),
      );
    } else if (_sortBy == 'Supplier') {
      filteredEstimates.sort((a, b) => a.supplier.compareTo(b.supplier));
    }
  }

  void _filterEstimates() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEstimates = estimates.where((e) {
        final match = e.supplier.toLowerCase().contains(query) ||
                      e.item.toLowerCase().contains(query);
        return (showDeleted ? e.isDeleted : !e.isDeleted) && match;
      }).toList();
      _sortEstimates();
    });
  }

  @override
  void dispose() {
    _supplierController.dispose();
    _itemController.dispose();
    _priceController.dispose();
    _dateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showDeleted ? '削除済み一覧' : 'Estimate Tracker'),
        actions: [
          IconButton(
            icon: Icon(showDeleted ? Icons.list : Icons.delete),
            tooltip: showDeleted ? '通常一覧へ戻る' : '削除済み一覧を見る',
            onPressed: () {
              setState(() {
                showDeleted = !showDeleted;
                _loadEstimates();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _supplierController,
              decoration: InputDecoration(labelText: 'Supplier Name'),
            ),
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Unit Price (JPY)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Delivery Date'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addEstimate,
              child: Text('Add Estimate'),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text('Sort by: '),
                DropdownButton<String>(
                  value: _sortBy,
                  items:
                      ['None', 'Price', 'Date', 'Supplier']
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _sortBy = value!;
                      _sortEstimates();
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by supplier or item',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEstimates.length,
                itemBuilder: (context, index) {
                  final est = filteredEstimates[index];
                  return Dismissible(
                    key: Key(est.key.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('削除の確認'),
                            content: Text('この見積を削除しますか？'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: Text('キャンセル'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: Text('削除する'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      est.isDeleted = true;
                      est.save(); // Hiveに反映
                      _loadEstimates(); // 表示更新
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('見積を削除しました')),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('${est.supplier} - ${est.item}'),
                        subtitle: Text('¥${est.price} | Delivery: ${est.deliveryDate}'),
                        trailing: showDeleted
                            ? IconButton(
                                icon: Icon(Icons.restore),
                                tooltip: '復元',
                                onPressed: () {
                                  est.isDeleted = false;
                                  est.save();
                                  _loadEstimates();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('見積を復元しました')),
                                  );
                                },
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showDeleted)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('本当に削除しますか？'),
                        content: Text('削除済みの見積をすべて完全に削除します。復元はできません。'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('削除する'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      final toDelete = estimateBox.values.where((e) => e.isDeleted).toList();
                      for (final est in toDelete) {
                        await est.delete();
                      }
                      _loadEstimates();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('削除済み見積をすべて削除しました')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  icon: Icon(Icons.delete_forever),
                  label: Text('削除済みをすべて完全削除'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
