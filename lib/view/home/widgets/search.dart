import 'package:tubes_money_management/provider/provider_transaction.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../models/category_model/category_model.dart';
import '../../screens/basescreen/decoration.dart';
import '../../screens/transactions/transaction_delet.dart';
import '../../screens/transactions/widget/all_transaction.dart';

class MainSerchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: const Icon(Icons.close, color: Colors.black))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 233, 252),
        body: Consumer<ProviderTransaction>(
          builder: (context, value, child) {
            return value.transactionlist.isEmpty
                ? Center(
                    child: Lottie.asset(
                        'assets/image/nosearchresultsanimation.json'),
                  )
                : ListView.separated(
                    itemCount: value.transactionlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentTransaction(result: value.transactionlist);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                  );
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 233, 252),
        body: Consumer<ProviderTransaction>(builder: (context, value, child) {
          return value.transactionlist.isEmpty
              ? Center(
                  child: Lottie.asset(
                      'assets/image/nosearchresultsanimation.json'),
                )
              : ListView.separated(
                  itemCount: value.transactionlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    final values = value.transactionlist[index];
                    if (values.category.name.contains(query.trim()) ||
                        values.description.contains(query.trim())) {
                      return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Slidable(
                            startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) {},
                                    backgroundColor: Colors.green,
                                    icon: Icons.edit,
                                  ),
                                ]),
                            endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(15),
                                    onPressed: (context) {
                                      transactiondelet(value, context);
                                    },
                                    backgroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ]),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                      values.category.image.toString()),
                                ),
                                title: textBig(
                                    text: values.category.name,
                                    size: 18,
                                    color: Colors.black,
                                    weight: FontWeight.w600),
                                trailing: Text(
                                  'Rp. ${values.amount}',
                                  style: TextStyle(
                                    color: values.type == CategoryType.income
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: textBigG(
                                    text: values.description,
                                    align: TextAlign.start,
                                    size: 13),
                              ),
                            ),
                          ));
                    } else {
                      return const SizedBox();
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                );
        }));
  }
}
