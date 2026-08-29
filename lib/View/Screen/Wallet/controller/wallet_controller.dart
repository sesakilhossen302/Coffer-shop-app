import 'package:get/get.dart';
import '../model/transaction_model.dart';

class WalletController extends GetxController {
  final RxString walletBalance = '1200 MXN'.obs;

  final RxList<TransactionModel> transactions = <TransactionModel>[
    TransactionModel(
      id: 't1',
      title: 'Caffecito (Gift Card)',
      subtitle: 'Purchase',
      amount: '-400 MXN',
      date: 'Today, 10:20 AM',
      type: TransactionType.giftCard,
      isPositive: false,
    ),
    TransactionModel(
      id: 't2',
      title: 'Caffecito (Order)',
      subtitle: 'Payment',
      amount: '-400 MXN',
      date: 'Yesterday, 2:11 PM',
      type: TransactionType.order,
      isPositive: false,
    ),
    TransactionModel(
      id: 't3',
      title: 'Added Money',
      subtitle: 'From card **** 5370',
      amount: '+400 MXN',
      date: '10 May, 10:20 AM',
      type: TransactionType.addedMoney,
      isPositive: true,
    ),
    TransactionModel(
      id: 't4',
      title: 'Caffecito (Order)',
      subtitle: 'Payment',
      amount: '-400 MXN',
      date: '12 Feb, 3:54 PM',
      type: TransactionType.order,
      isPositive: false,
    ),
    TransactionModel(
      id: 't5',
      title: 'Added Money',
      subtitle: 'From card **** 4521',
      amount: '+400 MXN',
      date: '10 Apr, 5:20 PM',
      type: TransactionType.addedMoney,
      isPositive: true,
    ),
    TransactionModel(
      id: 't6',
      title: 'Caffecito (Order)',
      subtitle: 'Payment',
      amount: '-400 MXN',
      date: '12 Feb, 3:54 PM',
      type: TransactionType.order,
      isPositive: false,
    ),
    TransactionModel(
      id: 't7',
      title: 'Sent Card',
      subtitle: 'To Fariha Aktar',
      amount: '-400 MXN',
      date: '21 Jan, 2:14 PM',
      type: TransactionType.sentCard,
      isPositive: false,
    ),
  ].obs;
}
