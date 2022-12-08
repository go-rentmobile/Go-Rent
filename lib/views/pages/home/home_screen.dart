import 'package:flutter/material.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/data_unit_service.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/confirm_whatsapp.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:go_rent/views/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  bool isLoading = false;
  List<DataUnitModel> products = [];

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      products = await DataUnitService().getDataUnit();
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header() {
      return Container(
        height: 120.0,
        padding: const EdgeInsets.only(top: 25.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20.0,
            ),
            Image.network(
              "https://ui-avatars.com/api/?name=${user.username}&color=7F9CF5&background=random&rounded=true&size=60",
              width: 60.0,
              height: 60.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${user.username}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: semibold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget searchInput() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Autocomplete<DataUnitModel>(
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (text) => onFieldSubmitted(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Cari macam kendaraan disini',
                  labelStyle: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              );
            },
            initialValue: const TextEditingValue(text: ''),
            onSelected: (DataUnitModel value) {
              AccessWhatsApp.confirmWhatsApp(context, user, value.nama!);
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<DataUnitModel>.empty();
              }
              return products.where((DataUnitModel option) {
                return option.nama
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            displayStringForOption: (option) {
              return option.nama!;
            },
            optionsViewBuilder: (context, onSelected, options) => Align(
              alignment: Alignment.topLeft,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(4.0),
                  ),
                ),
                child: Container(
                  width: constraints.biggest.width,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[300]!,
                          ),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            bool selected =
                                AutocompleteHighlightedOption.of(context) ==
                                    index;
                            DataUnitModel option = options.elementAt(index);

                            return InkWell(
                              onTap: () => onSelected(option),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Theme.of(context).focusColor
                                      : null,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      index == 0 ? 12 : 0,
                                    ),
                                    topRight: Radius.circular(
                                      index == 0 ? 12 : 0,
                                    ),
                                    bottomLeft: Radius.circular(
                                      index == options.length - 1 ? 12 : 0.0,
                                    ),
                                    bottomRight: Radius.circular(
                                      index == options.length - 1 ? 12 : 0.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      option.gambar!,
                                    ),
                                  ),
                                  title: Text("${option.nama}"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    }

    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Text("Tidak ada kendaraan ?"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Ayo cari kendaraan rental disini",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: semibold,
              ),
            ),
          ),

          // SEARCH
          searchInput(),
          const SizedBox(
            height: 40.0,
          ),

          // KATALOG PRODUCT
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                isLoading
                    ? const LoadingWidget()
                    : Row(
                        children: products
                            .map((product) => ProductCard(product))
                            .toList(),
                      ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),

          // POPULAR PRODUCT
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 35, 20, 0),
            child: Text(
              "Populer",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                isLoading
                    ? const LoadingWidget()
                    : Row(
                        children: products
                            .map(
                              (product) => InkWell(
                                onTap: () => AccessWhatsApp.confirmWhatsApp(
                                    context, user, product.nama!),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.gambar!,
                                      width: 180.0,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),
        ],
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
