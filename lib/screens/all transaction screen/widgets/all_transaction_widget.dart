import 'package:flutter/material.dart';
import 'package:my_wallet_app/models/transaction_model.dart';

import '../all_transaction_screen.dart';
import 'widgets.dart';

class AllTransactionWidget extends StatelessWidget {
  final List<TransactionModel> data;
  AllTransactionWidget({super.key, required this.data});

  final DateTime defaultDate = DateTime.now();
  final startDate = dateRange.start;
  final endDate = dateRange.end;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          TransactionModel dataAtIndex = data[index];
          //filters for income
          if (dropDownValue == 'Income' && dataAtIndex.type == 'income') {
            if (dataFilterValue == 'Today') {
              if (dataAtIndex.dateTime.month == defaultDate.month &&
                  dataAtIndex.dateTime.day == defaultDate.day) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
              //Custom
            } else if (dataFilterValue == 'Custom') {
              if (dataAtIndex.dateTime.isAfter(startDate) &&
                  dataAtIndex.dateTime.isBefore(endDate)) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
              //all
            } else if (dataFilterValue == 'All') {
              return allTransactionIncomeTile(
                  dataAtIndex.amount,
                  dataAtIndex.note,
                  dataAtIndex.date,
                  index,
                  dataAtIndex.type,
                  dataAtIndex.dateTime);
            } else if (dataFilterValue == 'Monthly') {
              //Monthly
              if (yearFilterValue == 'JAN' && dataAtIndex.dateTime.month == 1) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'FEB' &&
                  dataAtIndex.dateTime.month == 2) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'MAR' &&
                  dataAtIndex.dateTime.month == 3) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'APR' &&
                  dataAtIndex.dateTime.month == 4) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'MAY' &&
                  dataAtIndex.dateTime.month == 5) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'JUN' &&
                  dataAtIndex.dateTime.month == 6) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'JUL' &&
                  dataAtIndex.dateTime.month == 7) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'AUG' &&
                  dataAtIndex.dateTime.month == 8) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'SEP' &&
                  dataAtIndex.dateTime.month == 9) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'OCT' &&
                  dataAtIndex.dateTime.month == 10) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'NOV' &&
                  dataAtIndex.dateTime.month == 11) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'DEC' &&
                  dataAtIndex.dateTime.month == 12) {
                return allTransactionIncomeTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
            }
          } else if (dropDownValue == 'Expense' &&
              dataAtIndex.type == 'expense') {
            /////Expense Filtration

            if (dataFilterValue == 'All') {
              return allTransactionExpenseTile(
                  dataAtIndex.amount,
                  dataAtIndex.note,
                  dataAtIndex.date,
                  index,
                  dataAtIndex.type,
                  dataAtIndex.dateTime);
            } else if (dataFilterValue == 'Today') {
              if (dataAtIndex.dateTime.month == defaultDate.month &&
                  dataAtIndex.dateTime.day == defaultDate.day) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
            } else if (dataFilterValue == 'Custom') {
              if (dataAtIndex.dateTime.isAfter(startDate) &&
                  dataAtIndex.dateTime.isBefore(endDate)) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
            } else if (dataFilterValue == 'Monthly') {
              //Monthly
              if (yearFilterValue == 'JAN' && dataAtIndex.dateTime.month == 1) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'FEB' &&
                  dataAtIndex.dateTime.month == 2) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'MAR' &&
                  dataAtIndex.dateTime.month == 3) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'APR' &&
                  dataAtIndex.dateTime.month == 4) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'MAY' &&
                  dataAtIndex.dateTime.month == 5) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'JUN' &&
                  dataAtIndex.dateTime.month == 6) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'JUL' &&
                  dataAtIndex.dateTime.month == 7) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'AUG' &&
                  dataAtIndex.dateTime.month == 8) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'SEP' &&
                  dataAtIndex.dateTime.month == 9) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'OCT' &&
                  dataAtIndex.dateTime.month == 10) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'NOV' &&
                  dataAtIndex.dateTime.month == 11) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              } else if (yearFilterValue == 'DEC' &&
                  dataAtIndex.dateTime.month == 12) {
                return allTransactionExpenseTile(
                    dataAtIndex.amount,
                    dataAtIndex.note,
                    dataAtIndex.date,
                    index,
                    dataAtIndex.type,
                    dataAtIndex.dateTime);
              }
            }
          } else {
            if (dropDownValue == 'All') {
              if (dataAtIndex.type == 'income') {
                if (dataFilterValue == 'All') {
                  return allTransactionIncomeTile(
                      dataAtIndex.amount,
                      dataAtIndex.note,
                      dataAtIndex.date,
                      index,
                      dataAtIndex.type,
                      dataAtIndex.dateTime);
                } else if (dataFilterValue == 'Today') {
                  if (dataAtIndex.dateTime.month == defaultDate.month &&
                      dataAtIndex.dateTime.day == defaultDate.day) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                } else if (dataFilterValue == 'Custom') {
                  if (dataAtIndex.dateTime.isAfter(startDate) &&
                      dataAtIndex.dateTime.isBefore(endDate)) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                } else if (dataFilterValue == 'Monthly') {
                  if (yearFilterValue == 'JAN' &&
                      dataAtIndex.dateTime.month == 1) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'FEB' &&
                      dataAtIndex.dateTime.month == 2) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'MAR' &&
                      dataAtIndex.dateTime.month == 3) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'APR' &&
                      dataAtIndex.dateTime.month == 4) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'MAY' &&
                      dataAtIndex.dateTime.month == 5) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'JUN' &&
                      dataAtIndex.dateTime.month == 6) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'JUL' &&
                      dataAtIndex.dateTime.month == 7) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'AUG' &&
                      dataAtIndex.dateTime.month == 8) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'SEP' &&
                      dataAtIndex.dateTime.month == 9) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'OCT' &&
                      dataAtIndex.dateTime.month == 10) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'NOV' &&
                      dataAtIndex.dateTime.month == 11) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'DEC' &&
                      dataAtIndex.dateTime.month == 12) {
                    return allTransactionIncomeTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                }
              } else {
                if (dataFilterValue == 'All') {
                  return allTransactionExpenseTile(
                      dataAtIndex.amount,
                      dataAtIndex.note,
                      dataAtIndex.date,
                      index,
                      dataAtIndex.type,
                      dataAtIndex.dateTime);
                } else if (dataFilterValue == 'Today') {
                  if (dataAtIndex.dateTime.month == defaultDate.month &&
                      dataAtIndex.dateTime.day == defaultDate.day) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                } else if (dataFilterValue == 'Custom') {
                  if (dataAtIndex.dateTime.isAfter(startDate) &&
                      dataAtIndex.dateTime.isBefore(endDate)) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                } else if (dataFilterValue == 'Monthly') {
                  if (yearFilterValue == 'JAN' &&
                      dataAtIndex.dateTime.month == 1) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'FEB' &&
                      dataAtIndex.dateTime.month == 2) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'MAR' &&
                      dataAtIndex.dateTime.month == 3) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'APR' &&
                      dataAtIndex.dateTime.month == 4) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'MAY' &&
                      dataAtIndex.dateTime.month == 5) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'JUN' &&
                      dataAtIndex.dateTime.month == 6) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'JUL' &&
                      dataAtIndex.dateTime.month == 7) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'AUG' &&
                      dataAtIndex.dateTime.month == 8) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'SEP' &&
                      dataAtIndex.dateTime.month == 9) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'OCT' &&
                      dataAtIndex.dateTime.month == 10) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'NOV' &&
                      dataAtIndex.dateTime.month == 11) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  } else if (yearFilterValue == 'DEC' &&
                      dataAtIndex.dateTime.month == 12) {
                    return allTransactionExpenseTile(
                        dataAtIndex.amount,
                        dataAtIndex.note,
                        dataAtIndex.date,
                        index,
                        dataAtIndex.type,
                        dataAtIndex.dateTime);
                  }
                }
              }
            }
          }
          return const SizedBox();
        });
  }
}
