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
      filteredEstimates.sort((a, b) => a.deliveryDate.compareTo(b.deliveryDate));
    } else if (_sortBy == 'Supplier') {
      filteredEstimates.sort((a, b) => a.supplier.compareTo(b.supplier));
    }
  }

  void _filterEstimates() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEstimates = estimates.where((e) {
        return e.supplier.toLowerCase().contains(query) ||
               e.item.toLowerCase().contains(query);
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
      appBar: AppBar(title: Text('Estimate Tracker')),
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
                  items: ['None', 'Price', 'Date', 'Supplier']
                      .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                          value: value, child: Text(value)))
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
                  return Card(
                    child: ListTile(
                      title: Text('${est.supplier} - ${est.item}'),
                      subtitle: Text('¥${est.price} | Delivery: ${est.deliveryDate}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
