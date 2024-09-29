import 'package:flutter/material.dart';
import 'package:gelir_gider_mobil_app/hesapGirisEkrani.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController txtGelir = TextEditingController();
  TextEditingController txtGider = TextEditingController();
  TextEditingController txtTarih = TextEditingController();
  DateTime? selectedDate;

  List<Map<String, dynamic>> transactions = []; // Gelir/Gider listesi
  double totalBalance = 0.0; // Kalan toplam para
  double totalGelir = 0.0; // Toplam gelir
  double totalGider = 0.0; // Toplam gider

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veri Giriş Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtGelir,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gelir Giriniz'),
            ),
            TextFormField(
              controller: txtGider,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gider Giriniz'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: txtTarih,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Tarih Seçin'),
              onTap: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (selectedDate != null) {
                  setState(() {
                    txtTarih.text = '${selectedDate!.toLocal()}'.split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedDate != null &&
                    (txtGelir.text.isNotEmpty || txtGider.text.isNotEmpty)) {
                  // Gelir veya gider eklenmişse listeye ekle
                  setState(() {
                    double gelir = txtGelir.text.isNotEmpty
                        ? double.parse(txtGelir.text)
                        : 0.0;
                    double gider = txtGider.text.isNotEmpty
                        ? double.parse(txtGider.text)
                        : 0.0;

                    // Gelir veya gideri listeye ekle
                    transactions.add({
                      'gelir': gelir,
                      'gider': gider,
                      'tarih': selectedDate!.toLocal().toString().split(' ')[0],
                    });

                    // Toplam gelir ve gider güncelle
                    totalGelir += gelir;
                    totalGider += gider;

                    // Kalan para güncelle
                    totalBalance = totalGelir - totalGider;

                    // TextField'ları temizle
                    txtGelir.clear();
                    txtGider.clear();
                    txtTarih.clear();
                    selectedDate = null;
                  });
                }
              },
              child: Text('Ekle'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  var transaction = transactions[index];
                  return ListTile(
                    title: Text(
                        'Gelir: ${transaction['gelir']} - Gider: ${transaction['gider']}'),
                    subtitle: Text('Tarih: ${transaction['tarih']}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Toplam Kalan Para Gösterimi
            Text(
              'Toplam Gelir: $totalGelir',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Toplam Gider: $totalGider',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Toplam Kalan Para: $totalBalance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Hesap Giriş Ekranı'na Toplam Para Aktaran Buton
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HesapGirisEkrani(
                      totalGelir: totalGelir,
                      totalGider: totalGider,
                      totalBalance: totalBalance,
                      transactions: transactions,
                    ),
                  ),
                );
              },
              child: Text('Hesap Giriş Ekranına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
