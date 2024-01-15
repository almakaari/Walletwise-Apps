import 'package:flutter/material.dart';
import 'package:walletwise_app/shared/theme.dart';

class HistoryTransactionItem extends StatelessWidget {
  const HistoryTransactionItem({
    Key? key,
    required this.iconUrl,
    required this.title,
    required this.date,
    required this.value,
    required this.onDelete,
  }) : super(key: key);

  final String iconUrl;
  final String title;
  final String date;
  final String value;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(iconUrl),
      title: Text(title, style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
      subtitle: Text(date, style: greyTextStyle.copyWith(fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium)),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete, // Call onDelete when the delete button is pressed
          ),
        ],
      ),
    );
  }
}
