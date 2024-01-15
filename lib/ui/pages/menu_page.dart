import 'package:walletwise_app/models/catatan.dart';
import 'package:walletwise_app/shared/separator.dart';
import 'package:walletwise_app/shared/shared_methods.dart';
import 'package:walletwise_app/shared/shared_preferences.dart';
import 'package:walletwise_app/shared/theme.dart';
import 'package:walletwise_app/ui/widgets/history_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Catatan> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String catatanString = prefs.getString('catatan_key') ?? '';

    if (catatanString.isNotEmpty) {
      setState(() {
        transactions = Catatan.decode(catatanString);
      });
    }
  }

  Future<void> _addTransaction(Catatan newTransaction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil data transaksi yang sudah ada
    String? transactionsString = prefs.getString('catatan_key');

    List<Catatan> updatedTransactions;
    if (transactionsString != null && transactionsString.isNotEmpty) {
      // Decode string menjadi list transaksi
      List<Catatan> existingTransactions = Catatan.decode(transactionsString);

      // Tambahkan transaksi baru ke list
      existingTransactions.add(newTransaction);

      updatedTransactions = existingTransactions;
    } else {
      // Jika tidak ada data sebelumnya, buat list baru
      updatedTransactions = [newTransaction];
    }

    // Encode list transaksi ke dalam string
    String updatedTransactionsString = Catatan.encode(updatedTransactions);

    // Simpan data transaksi dalam SharedPreferences
    prefs.setString('catatan_key', updatedTransactionsString);

    setState(() {
      transactions = updatedTransactions;
    });
  }

  Future<void> _refreshTransactions() async {
    // Implementasikan logika refresh transaksi di sini
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      transactions = [];
    });
    // Contoh: Ambil data transaksi terbaru dari SharedPreferences
    await _loadTransactions();
  }

  void _onAddTransaction(Catatan newTransaction) {
    _addTransaction(newTransaction);
    // Tambahkan navigasi atau tindakan lain yang diperlukan setelah menambahkan transaksi
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshTransactions,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            buildProfile(context),
            buildWallet(context),
            buildHistory(context),
          ],
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang!',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              FutureBuilder(
                future: SharedPrefUtils.readNama(),
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: FutureBuilder(
              future: SharedPrefUtils.readNameImage(),
              builder: (context, snapshot) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: snapshot.data == null
                          ? const AssetImage('assets/image-1.png')
                          : AssetImage('assets/${snapshot.data}.png'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWallet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/img_bg_card.png'),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo',
              style: whiteTextStyle,
            ),
            FutureBuilder(
              future: SharedPrefUtils.readSaldo(),
              builder: (context, snapshot) {
                return Text(
                  '${formatCurrency(snapshot.data)}',
                  style: whiteTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Separator(
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemasukan',
                      style: whiteTextStyle,
                    ),
                    FutureBuilder(
                      future: SharedPrefUtils.readPemasukan(),
                      builder: (context, snapshot) {
                        return Text(
                          '${formatCurrency(snapshot.data)}',
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        );
                      },
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran',
                      style: whiteTextStyle,
                    ),
                    FutureBuilder(
                      future: SharedPrefUtils.readPengeluaran(),
                      builder: (context, snapshot) {
                        return Text(
                          formatCurrency(snapshot.data),
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 // Inside the _MenuPageState class

// ...

Widget buildHistory(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Histori Transaksi',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(bottom: 22, left: 22, right: 22),
            margin: const EdgeInsets.only(
              top: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context, index) => HistoryTransactionItem(
                iconUrl: transactions[index].tipeTransaksi.toString() == 'pemasukan'
                    ? 'assets/transaksi_pemasukan.png'
                    : 'assets/transaksi_pengeluaran.png',
                title: transactions[index].kategori.toString(),
                date: transactions[index].tanggal.toString(),
                value: transactions[index].tipeTransaksi.toString() == 'pemasukan'
                    ? '+ ${formatCurrency(transactions[index].jumlah, symbol: '')}'
                    : '- ${formatCurrency(transactions[index].jumlah, symbol: '')}',
                onDelete: () => _deleteTransaction(index), // Call _deleteTransaction when delete button is pressed
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Function to delete a transaction
void _deleteTransaction(int index) {
  setState(() {
    transactions.removeAt(index);
  });

  // Update SharedPreferences after deleting
  _updateSharedPreferences();
}

// Function to update SharedPreferences after modifying transactions
Future<void> _updateSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String updatedTransactionsString = Catatan.encode(transactions);
  prefs.setString('catatan_key', updatedTransactionsString);
}
}