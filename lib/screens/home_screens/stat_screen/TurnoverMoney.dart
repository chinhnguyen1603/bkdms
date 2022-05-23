import 'package:bkdms/services/ConsumerProvider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/models/SaleOrder.dart';

class TurnoverMoney extends StatefulWidget {
  const TurnoverMoney({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TurnoverMoneyState();
}

class _TurnoverMoneyState extends State<TurnoverMoney> {
  final Color leftBarColor = const Color(0xffff5182);
  final double width = 12;
  late List<BarChartGroupData> showingBarGroups;

  // xử lý khi chạm vào thanh
  int touchedGroupIndex = -1;
 

  // lấy list đơn bán lẻ
  List<SaleOrder> lstSaleOrder = []; 
  late Future _myFuture;
  //
  @override
  void initState() {
    super.initState();
    Agency user = Provider.of<Agency>(context, listen: false);
    _myFuture = Provider.of<ConsumerProvider>(context, listen: false).saleHistory(user.token, user.workspace, user.id);  
    this.lstSaleOrder = Provider.of<ConsumerProvider>(context, listen: false).lstSaleOrder;
  }

  @override
  Widget build(BuildContext context) {
    //xử lí lấy tiền theo từng tháng
    double total1 = 0, total2 = 0, total3 = 0, total4 =0, total5 = 0, total6 = 0, total7=0, total8 =0, total9 = 0, total10 = 0, total11 =0, total12=0;
    for(var order in lstSaleOrder) {
      if (getMonth(order.createTime) == "01") {
        total1 += int.parse(order.totalPrice)/1000000;
      }
      if (getMonth(order.createTime) == "02") {
        total2 += int.parse(order.totalPrice)/1000000;
      }   
      if (getMonth(order.createTime) == "03") {
        total3 += int.parse(order.totalPrice)/1000000;
      }  
      if (getMonth(order.createTime) == "04") {
        total4 += int.parse(order.totalPrice)/1000000;
      }    
      if (getMonth(order.createTime) == "05") {
        total5 += int.parse(order.totalPrice)/1000000;
      }  
      if (getMonth(order.createTime) == "06") {
        total6 += int.parse(order.totalPrice)/1000000;
      }     
      if (getMonth(order.createTime) == "07") {
        total7 += int.parse(order.totalPrice)/1000000;
      }
      if (getMonth(order.createTime) == "08") {
        total8 += int.parse(order.totalPrice)/1000000;
      }   
      if (getMonth(order.createTime) == "09") {
        total9 += int.parse(order.totalPrice)/1000000;
      }  
      if (getMonth(order.createTime) == "10") {
        total10 += int.parse(order.totalPrice)/1000000;
      }  
      if (getMonth(order.createTime) == "11") {
        total11 += int.parse(order.totalPrice)/1000000;
      }    
      if (getMonth(order.createTime) == "12") {
        total12 += int.parse(order.totalPrice)/1000000;
      }                                                                 
    }
    //gán giá trị tổng tiền tại đây
    var barGroup1 = makeGroupData(0, total1,); //giá trị tổng tiền nằm ở cột y, cột x là 0 -> 11 [đại diện cho tháng 1-12]
    var barGroup2 = makeGroupData(1, total2);
    var barGroup3 = makeGroupData(2, total3);
    var barGroup4 = makeGroupData(3, total4);
    var barGroup5 = makeGroupData(4, total5);
    var barGroup6 = makeGroupData(5, total6);
    var barGroup7 = makeGroupData(6, total7);
    var barGroup8 = makeGroupData(7, total8);
    var barGroup9 = makeGroupData(8, total9);
    var barGroup10 = makeGroupData(9, total10);
    var barGroup11 = makeGroupData(10, total11); 
    var barGroup12 = makeGroupData(11, total12);             
    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,      
    ];
    showingBarGroups = items;    
    //
    return FutureBuilder<void>(
      future: _myFuture,
      builder: (context, snapshot) {
        return AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff2c4260),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //chứa hiệu ứng + chữ VND
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      makeTransactionsIcon(),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'VND',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                   ],
                  ),
                  
                  //
                  const SizedBox(
                    height: 38,
                  ),

                  //widget biểu đồ tại đây
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: 50,
                        //xử lý khi người dùng chạm vào thanh biểu đồ
                        barTouchData: BarTouchData(
                          enabled: true,
                          handleBuiltInTouches: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            tooltipMargin: 0,
                            getTooltipItem: (
                              BarChartGroupData group,
                              int groupIndex,
                              BarChartRodData rod,
                              int rodIndex,
                            ) {
                              return BarTooltipItem(
                                rod.toY.toString(),
                                TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: rod.color!,
                                    fontSize: 18,
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black26,
                                        blurRadius: 12,
                                      )
                                    ]),
                              );
                            }),
                            touchCallback: (event, response) {
                              if (event.isInterestedForInteractions && response != null && response.spot != null) {
                                setState(() {
                                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                                });
                              } else {
                                setState(() {
                                  touchedGroupIndex = -1;
                                });
                              }
                            },
                        ),                    
                        //wiget thanh diễn dãi trái, phải, trên, dưới -> [số tiền + tên tháng]
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                              interval: 1,
                              reservedSize: 42,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 26,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        //dữ liệu
                        barGroups: showingBarGroups,
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }


  //thao tác cột bên trái chứa mốc triệu VND
  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xfffdfdfd),
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    String text;
    if (value == 1) {
      text = '1M';
    } 
    else if (value == 10) {
      text = '10M';
    } 
    else if (value == 20) {
      text = '20M';
    } 
    else if (value == 50) {
      text = '50M';
    }     
    else {
      return Container();
    }
    return Text(text, style: style);
  }

  //thao tác cột nằm dưới chứa mốc thời gian [tháng]
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xfffdfdfd),
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'Jan',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'Feb',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Mar',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'Apr',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'May',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'Jun',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'Jul',
          style: style,
        );
        break;
      case 7:
        text = const Text(
          'Aug',
          style: style,
        );
        break;     
      case 8:
        text = const Text(
          'Sep',
          style: style,
        );
        break;   
      case 9:
        text = const Text(
          'Oct',
          style: style,
        );
        break;   
      case 10:
        text = const Text(
          'Nov',
          style: style,
        );
        break;  
      case 11:
        text = const Text(
          'Dec',
          style: style,
        );
        break;                                                
      default:
        text = const Text(
          '',
          style: style,
        );
        break;
    }
    return Padding(padding: const EdgeInsets.only(top: 20), child: text);
  }

  //hàm lấy dữ liệu của thanh, x là mốc thời gian, y là số tiền
  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(barsSpace: 4, x: x, showingTooltipIndicators: touchedGroupIndex == x ? [0] : [], barRods: [
      BarChartRodData(
        toY: y,
        color: leftBarColor,
        width: width,
      ),
   ]);
   
  }

  //widget tạo hiệu ứng bên trái chữ VND
  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  // Hàm lấy tháng của đơn hàng
  String getMonth(String time){
    var timeConvert = DateFormat('MM').format(DateTime.parse(time).toLocal());
    return timeConvert;
  }
 

}