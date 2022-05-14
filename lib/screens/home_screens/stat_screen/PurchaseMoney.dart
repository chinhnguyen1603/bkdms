import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PurchaseMoney extends StatefulWidget {
  const PurchaseMoney({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PurchaseMoneyState();
}

class _PurchaseMoneyState extends State<PurchaseMoney> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final double width = 12;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  // xử lý khi chạm vào thanh
  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    //gán giá trị tổng tiền tại đây
    final barGroup1 = makeGroupData(0, 5,); //giá trị tổng tiền nằm ở cột y, cột x là 0 -> 11 [đại diện cho tháng 1-12]
    final barGroup2 = makeGroupData(1, 16);
    final barGroup3 = makeGroupData(2, 18);
    final barGroup4 = makeGroupData(3, 20);
    final barGroup5 = makeGroupData(4, 17);
    final barGroup6 = makeGroupData(5, 19);
    final barGroup7 = makeGroupData(6, 0);
    final barGroup8 = makeGroupData(7, 2);
    final barGroup9 = makeGroupData(8, 3);
    final barGroup10 = makeGroupData(9, 19);
    final barGroup11 = makeGroupData(10, 12); 
    final barGroup12 = makeGroupData(11, 9);             
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

    rawBarGroups = items;

    showingBarGroups = items;
  }

  @override
  Widget build(BuildContext context) {
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
                    maxY: 20,
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
    else if (value == 5) {
      text = '5M';
    }
    else if (value == 10) {
      text = '10M';
    } 
    else if (value == 20) {
      text = '20M';
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


}