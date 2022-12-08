import 'package:flutter/material.dart';
import 'package:go_rent/models/history_model.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/services/history_service.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/history_tile.dart';
import 'package:go_rent/views/widgets/loading.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  bool isLoading = false;
  List<HistoryModel> histories = [];

  Future<void> loadHistory() async {
    setState(() {
      isLoading = true;
    });

    try {
      histories =
          await HistoryService().gethistory(int.parse(widget.user.idUser!));
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        height: 100.0,
        padding: const EdgeInsets.only(top: 25.0, left: 20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            Text(
              "History",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: semibold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return histories.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height - 200.0,
              child: const Center(
                child: Text(
                  'Belum ada transaksi',
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                  ),
                ),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: isLoading
                  ? const LoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: histories
                          .map((product) => HistoryTile(product))
                          .toList(),
                    ),
            );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
