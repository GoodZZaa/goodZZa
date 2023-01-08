// import 'package:flutter/material.dart';
// import 'package:good_zza_code_in_songdo/models/payments.dart';
// import 'package:good_zza_code_in_songdo/utills/day_to_weekday.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../provider/account_book_provider.dart';

// class AccountBook extends StatefulWidget {
//   const AccountBook({super.key});

//   @override
//   State<AccountBook> createState() => _AccountBookState();
// }

// class _AccountBookState extends State<AccountBook>
//     with TickerProviderStateMixin {
//   late AccountProvider _accountProvider;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _accountProvider = Provider.of<AccountProvider>(context, listen: false);
//     _accountProvider.init();

//     _tabController = TabController(
//         length: _accountProvider.days.length,
//         vsync: this,
//         initialIndex: DateTime.now().day - 1);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _accountProvider = Provider.of<AccountProvider>(context);

//     Widget paymentTabView() {
//       return Container(
//           child: Column(
//         children: [
//           TabBar(
//             onTap: (value) {
//               _accountProvider.setDay(value + 1);
//             },
//             labelPadding: const EdgeInsets.all(5),
//             controller: _tabController,
//             isScrollable: true,
//             tabs: _accountProvider.days
//                 .map((element) => Tab(
//                     height: 66,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                             decoration: element == _accountProvider.selectedDate
//                                 ? BoxDecoration(
//                                     borderRadius: BorderRadius.circular(7),
//                                     color:
//                                         const Color.fromRGBO(88, 212, 175, 1))
//                                 : BoxDecoration(
//                                     borderRadius: BorderRadius.circular(7),
//                                     color:
//                                         const Color.fromRGBO(255, 255, 255, 1)),
//                             alignment: Alignment.center,
//                             height: 50,
//                             width: 45,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                   dayToWeekday(element.weekday),
//                                   style: element ==
//                                           _accountProvider.selectedDate
//                                       ? const TextStyle(
//                                           fontSize: 10,
//                                           color: Color.fromRGBO(
//                                               255, 255, 255, 0.7))
//                                       : const TextStyle(
//                                           fontSize: 10,
//                                           color:
//                                               Color.fromRGBO(155, 156, 160, 1)),
//                                 ),
//                                 Text(
//                                   element.day.toString(),
//                                   style: element ==
//                                           _accountProvider.selectedDate
//                                       ? const TextStyle(
//                                           color:
//                                               Color.fromRGBO(248, 247, 255, 1),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         )
//                                       : const TextStyle(
//                                           color: Color.fromARGB(
//                                               0xFF, 0x36, 0x39, 0x42),
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                 )
//                               ],
//                             )),
//                         Container(
//                             padding: const EdgeInsets.only(top: 3),
//                             child: Icon(Icons.circle,
//                                 size: 8,
//                                 color: _accountProvider.paymentItems
//                                         .where((e) => e.date == element)
//                                         .toList()
//                                         .isEmpty
//                                     ? Colors.transparent
//                                     : const Color.fromRGBO(95, 89, 225, 1)))
//                       ],
//                     )))
//                 .toList(),
//             indicator: const BoxDecoration(color: Colors.transparent),
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
//             height: 1,
//             width: double.maxFinite,
//             color: const Color.fromRGBO(218, 218, 218, 1),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 7),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                     onTap: () {},
//                     child: Container(
//                       padding: const EdgeInsets.all(3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text('전체',
//                               style: TextStyle(
//                                   fontSize: 12.5, fontWeight: FontWeight.w600)),
//                           Icon(Icons.keyboard_arrow_down_sharp, size: 20)
//                         ],
//                       ),
//                     )),
//                 InkWell(
//                     child: Container(
//                         padding: const EdgeInsets.all(3),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 '추가하기',
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.w500),
//                               ),
//                               const SizedBox(
//                                 width: 8,
//                               ),
//                               Image.asset(
//                                 'assets/icons/icon_plus.png',
//                                 height: 26,
//                                 width: 26,
//                               )
//                             ])))
//               ],
//             ),
//           ),
//           Container(
//               height: 300,
//               child: TabBarView(
//                   controller: _tabController,
//                   children: _accountProvider.days
//                       .map((e) => paymentListView(_accountProvider.paymentItems
//                           .where((element) => element.date == e)
//                           .toList()))
//                       .toList()))
//         ],
//       ));
//     }

//     return Scaffold(
//         body: _accountProvider.state == AccountState.success
//             ? Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 color: const Color.fromRGBO(255, 255, 255, 1),
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     monthControll(),
//                     accountCard(),
//                     monthText(),
//                     paymentTabView()
//                   ],
//                 ))
//             : failMessageWidget());
//   }

//   void paymentBottomSheet(PaymentItem item) => showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
//       context: context,
//       builder: (BuildContext context) => Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//                   alignment: Alignment.topLeft,
//                   child: Column(
//                     children: [
//                       Text(
//                         '${item.price} 원',
//                         style: const TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         DateFormat('yyyy년 MM월 dd일').format(item.date),
//                         style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ))
//             ],
//           ));

//   Widget paymentListView(List<PaymentItem> items) {
//     return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         width: double.infinity,
//         child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: items.length,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (context, index) => paymentItemCard(items[index])));
//   }

//   Widget paymentItemCard(PaymentItem item) {
//     return Container(
//         margin: EdgeInsets.all(8),
//         child: InkWell(
//             onTap: () => paymentBottomSheet(item),
//             child: Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(color: Color.fromARGB(255, 175, 175, 175))
//                     ],
//                     border: Border(
//                         left: BorderSide(
//                             color: Color.fromRGBO(95, 89, 225, 1),
//                             width: 3.5))),
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         item.productName,
//                         style: const TextStyle(
//                           fontSize: 12.5,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       Text(
//                         item.market,
//                         style: const TextStyle(
//                             fontSize: 8.5,
//                             fontWeight: FontWeight.w400,
//                             color: Color.fromRGBO(97, 96, 96, 1)),
//                       ),
//                       Container(
//                         alignment: Alignment.centerRight,
//                         child: Text('${item.price}원',
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             textAlign: TextAlign.right),
//                       )
//                     ]))));
//   }

//   Widget monthControll() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         children: [
//           IconButton(
//               iconSize: 15,
//               onPressed: () {
//                 _accountProvider.setMonthBefore();
//                 _tabController = TabController(
//                     length: _accountProvider.days.length, vsync: this);
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//               )),
//           Text(
//             "${_accountProvider.selectedDate.month}월",
//             style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//             textAlign: TextAlign.start,
//           ),
//           IconButton(
//               iconSize: 15,
//               onPressed: () {
//                 _accountProvider.setMonthNext();
//                 _tabController = TabController(
//                     length: _accountProvider.days.length, vsync: this);
//               },
//               icon: const Icon(
//                 Icons.arrow_forward_ios,
//               )),
//         ],
//       ),
//     );
//   }

//   Widget accountCard() {
//     return Container(
//       height: 150,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         image: const DecorationImage(
//             image: AssetImage('assets/images/img_main_frame.png'),
//             fit: BoxFit.cover),
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '${_accountProvider.selectedDate.month}월 총 예산',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 13,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           Text('${_accountProvider.account.max}원',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               )),
//           Container(
//             alignment: Alignment.centerRight,
//             child: const Text(
//               '남은잔액',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//               ),
//               textAlign: TextAlign.right,
//             ),
//           ),
//           Container(
//               alignment: Alignment.centerRight,
//               child: Text(
//                   '${_accountProvider.account.max - _accountProvider.account.all}원',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 36,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.right))
//         ],
//       ),
//     );
//   }

//   Widget monthText() {
//     return Container(
//       padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
//       child: Column(
//         children: [
//           Container(
//             height: 1,
//             width: double.maxFinite,
//             color: const Color.fromRGBO(218, 218, 218, 1),
//             margin: const EdgeInsets.only(bottom: 10),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('${_accountProvider.selectedDate.month}월',
//                   style: const TextStyle(
//                       fontSize: 16,
//                       color: Color.fromRGBO(57, 63, 66, 1),
//                       fontWeight: FontWeight.w500)),
//               const SizedBox(
//                 width: 25,
//               ),
//               const Text('지출내역',
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Color.fromARGB(0xFF, 0x36, 0x39, 0x42),
//                       fontWeight: FontWeight.w700))
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 10, bottom: 10),
//             height: 1,
//             width: double.maxFinite,
//             color: const Color.fromRGBO(218, 218, 218, 1),
//           )
//         ],
//       ),
//     );
//   }

//   Widget failMessageWidget() {
//     switch (_accountProvider.state) {
//       case AccountState.loading:
//         return const Center(
//           child: CircularProgressIndicator(
//               color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
//         );
//       case AccountState.fail:
//         return const Center(
//             child:
//                 Text("원하는 경로가 없어요!\n다시 검색해주세요", textAlign: TextAlign.center));

//       default:
//         return const Center(
//           child: CircularProgressIndicator(
//               color: Color.fromARGB(0xFF, 0xFB, 0x95, 0x32)),
//         );
//     }
//   }
// }
