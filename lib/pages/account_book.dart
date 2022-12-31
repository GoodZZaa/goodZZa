import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/account_book_provider.dart';

class AccountBook extends StatefulWidget {
  const AccountBook({super.key});

  @override
  State<AccountBook> createState() => _AccountBookState();
}

class _AccountBookState extends State<AccountBook> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountProvider>(context, listen: false).getData();
  }

  late AccountProvider _accountProvider;

  @override
  Widget build(BuildContext context) {
    _accountProvider = Provider.of<AccountProvider>(context);

    return Scaffold(
        body: _accountProvider.state == AccountState.success
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [monthControll(), accountCard(), monthText()],
              )
            : failMessageWidget());
  }

  Widget monthControll() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 18, top: 20, bottom: 20),
      child: Row(
        children: [
          IconButton(
              iconSize: 15,
              onPressed: _accountProvider.setMinusDate,
              icon: const Icon(
                Icons.arrow_back_ios_new,
              )),
          Text(
            "${_accountProvider.month}월",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          IconButton(
              iconSize: 15,
              onPressed: _accountProvider.setPlusDate,
              icon: const Icon(
                Icons.arrow_forward_ios,
              )),
        ],
      ),
    );
  }

  Widget accountCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 298,
          height: 144,
          padding: const EdgeInsets.fromLTRB(16, 19, 14, 17),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_accountProvider.month}월 총 예산',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text('${_accountProvider.account.max}원',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
              Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  '남은잔액',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      '${_accountProvider.account.max - _accountProvider.account.all}원',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right))
            ],
          ),
        )
      ],
    );
  }

  Widget monthText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
      child: Column(
        children: [
          Container(
            height: 1,
            width: double.maxFinite,
            color: const Color.fromRGBO(218, 218, 218, 1),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${_accountProvider.month}월',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(57, 63, 66, 1),
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 25,
              ),
              const Text('지출내역',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(0xFF, 0x36, 0x39, 0x42),
                      fontWeight: FontWeight.w700))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 1,
            width: double.maxFinite,
            color: const Color.fromRGBO(218, 218, 218, 1),
          )
        ],
      ),
    );
  }

  Widget failMessageWidget() {
    switch (_accountProvider.state) {
      case AccountState.loading:
        return const Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
        );
      case AccountState.fail:
        return const Center(
            child:
                Text("원하는 경로가 없어요!\n다시 검색해주세요", textAlign: TextAlign.center));

      default:
        return const Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
        );
    }
  }
}
