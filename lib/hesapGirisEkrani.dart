import 'package:flutter/material.dart';

class HesapGirisEkrani extends StatefulWidget {
  final double totalGelir;
  final double totalGider;
  final double totalBalance;
  final List<Map<String, dynamic>> transactions;

  HesapGirisEkrani({
    required this.totalGelir,
    required this.totalGider,
    required this.totalBalance,
    required this.transactions,
  });

  @override
  _HesapGirisEkraniState createState() => _HesapGirisEkraniState();
}

class _HesapGirisEkraniState extends State<HesapGirisEkrani> {
  DateTime? filterDate;
  double? kalanPara;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesap Giriş Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Toplam Gelir: ${widget.totalGelir}'),
            Text('Toplam Gider: ${widget.totalGider}'),
            Text('Toplam Kalan Para: ${widget.totalBalance}'),
            SizedBox(height: 20),
            // Tarihe göre filtreleme yapmak için DatePicker
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    filterDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (filterDate != null) {
                      setState(() {
                        // Seçilen tarihe göre işlemleri filtrele
                        double filteredGelir = 0.0;
                        double filteredGider = 0.0;
                        for (var transaction in widget.transactions) {
                          if (transaction['tarih'] ==
                              '${filterDate!.toLocal()}'.split(' ')[0]) {
                            filteredGelir += transaction['gelir'];
                            filteredGider += transaction['gider'];
                          }
                        }
                        // Filtrelenen tarihe göre kalan parayı hesapla
                        kalanPara = filteredGelir - filteredGider;
                      });
                    }
                  },
                ),
                Text(filterDate == null
                    ? 'Tarih Seçin'
                    : '${filterDate!.toLocal()}'.split(' ')[0]),
              ],
            ),
            SizedBox(height: 20),
            // Kalan parayı gösterme
            kalanPara != null
                ? Text('Seçilen Tarihe Göre Net Kalan Para: $kalanPara')
                : Text('Henüz hesaplanmadı'),
          ],
        ),
      ),
    );
  }
}
