import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({ Key? key }) : super(key: key);

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  double myWidth = 90.w;
  static const greyBorder = Color(0xffe5efeb);
  static const bigTextColor = Color(0xff1d3a70);
  static const smallTextColor = Color(0xff6b7280);
  
  @override
  Widget build(BuildContext context) {  
    double widthInContainer = myWidth*0.9;
    //
    return Scaffold(
      appBar: AppBarTransparent(Color(0xfffdfdfd), "Công nợ"),
      backgroundColor: Color(0xfffdfdfd),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 100.w, height: 5,),
            //container card
            Container(
              width: myWidth,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(75, 106, 108, 114),
                    blurRadius: 3,        
                    offset: Offset(1,2), 
                  )
                ]
              ),
              child: Column(
                children: [
                  SizedBox(width: myWidth, height: 8,),
                  //tên cửa hàng + đang hoạt động
                  SizedBox(
                    width: widthInContainer,
                    height: 30,
                    child: Row(
                      children: [
                        SizedBox(
                          width: widthInContainer*0.65,
                          child: Text("Cửa hàng Trung Việt", textAlign: TextAlign.left, style: TextStyle(color: Color(0xff7b2626), fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        //container đang hoạt động
                        Container(
                          height: 20,
                          width: widthInContainer*0.35,
                          decoration: BoxDecoration(            
                            color: Color(0xffdaf7bd),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: myWidth*0.9*0.35,
                              child: Text("Đang hoạt động", textAlign: TextAlign.center ,style: TextStyle(color: Color(0xff6ab73e), fontSize: 12,))
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  
                  //text dư nợ cho phép + nợ tối đa
                  SizedBox(
                    width: widthInContainer,
                    child: Text("Dư nợ cho phép", style: TextStyle(color: Color(0xff544c4c)),),
                  ),
                  SizedBox(height: 3,),
                  SizedBox(
                    width: widthInContainer,
                    child: Text("900.000.000đ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  ),
                  
                  //dư nợ hiện tại + ngày thanh toán
                  SizedBox(height: 20,),
                  SizedBox(
                    width: widthInContainer,
                    height: 50,
                    child: Row(children: [
                      //dư nợ hiện tại
                      Container(
                        color: Color(0xffff9f9f9),
                        height: 50,
                        width: widthInContainer*0.42,
                        child: Row(
                          children: [
                            SizedBox(width: 8,),
                            //
                            Column(
                              children: [
                                SizedBox(height: 8,),
                                SizedBox(width:widthInContainer*0.4-8, child: Text("Dư nợ hiện tại", textAlign: TextAlign.left ,style: TextStyle(color: Color(0xff544c4c)))),
                                SizedBox(width:widthInContainer*0.4-8 ,child: Text("300.000.000đ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      //Ngày thanh toán
                      Container(
                        color: Color(0xffff9f9f9),
                        height: 50,
                        width: widthInContainer*0.42,
                        child: Row(
                          children: [
                            SizedBox(width: 8,),
                            //
                            Column(
                              children: [
                                SizedBox(height: 8,),
                                SizedBox(width:widthInContainer*0.4-8, child: Text("Ngày thanh toán", textAlign: TextAlign.left ,style: TextStyle(color: Color(0xff544c4c)))),
                                SizedBox(width:widthInContainer*0.4-8 ,child: Text("Ngày 5", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                              ],
                            ),
                          ],
                        ),
                      ),
 
                    ]),
                  )
               ],
              ),
            ),
            SizedBox(width: 100.w, height: 30,),
            
            //Hoạt động
            SizedBox(width: myWidth, child: Text("Hoạt động", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,),
            //3 icon button -> dùng gesturedetec
            SizedBox(
              width: myWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //lịch sử nợ
                  GestureDetector(
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.history, color: Color(0xff7b2626),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text("Lịch sử nợ"),
                      ],
                    ),
                  ),
                  //lịch sử thanh toán
                  GestureDetector(
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.credit_score, color: Color(0xffbfa652),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),                        
                        Text("Lịch sử thanh toán")
                      ],
                    ),
                  ),
                  //chính sách
                  GestureDetector(
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: greyBorder),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),                        
                          child: Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(Icons.post_add, color: Color(0xff105480),),
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),                          
                        Text("Chính sách")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 100.w, height: 25,),

            //Trả nợ
            SizedBox(width: myWidth, child: Text("Trả nợ", style: TextStyle(color: Color(0xff544c4c), fontSize: 18, fontWeight: FontWeight.w500),),),
            SizedBox(height: 10,),
            //Container chứa các phương thức thanht toán
            SizedBox(
              width: myWidth,
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //tiền mặt
                  Container(
                    height: 70,
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyBorder),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),                        
                    child: SizedBox(
                      width: myWidth,
                      height: 70,
                      child: Row(
                        children: [
                          //ảnh
                          SizedBox(
                            width: myWidth*0.3,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xfff9fafb),
                                shape: BoxShape.circle,
                              ),   
                              child: SizedBox(height: 30,width: 30, child: Image.asset("assets/totalMoney.png", fit: BoxFit.cover,), )
                            ),
                          ),                         
                          //text 
                          SizedBox(
                            height: 70,
                            width: myWidth*0.6,
                            child: Column(
                              children: [
                                SizedBox(height: 12,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Tiền mặt", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                ),
                                SizedBox(height: 3,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Phổ biến", style: TextStyle(color: smallTextColor, fontSize: 12))
                                )
                              ],
                            ),
                          ) 
                        ],
                      ),
                    ),
                  ),
                  //chuyển khoản
                  Container(
                    height: 70,
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyBorder),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),                        
                    child: SizedBox(
                      width: myWidth,
                      height: 70,
                      child: Row(
                        children: [
                          //ảnh
                          SizedBox(
                            width: myWidth*0.3,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xfff9fafb),
                                shape: BoxShape.circle,
                              ),   
                              child: SizedBox(height: 30,width: 30, child: Image.asset("assets/banking.png", fit: BoxFit.cover,), )
                            ),
                          ),                         
                          //text 
                          SizedBox(
                            height: 70,
                            width: myWidth*0.6,
                            child: Column(
                              children: [
                                SizedBox(height: 12,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Chuyển khoản", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                ),
                                SizedBox(height: 3,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("24/7", style: TextStyle(color: smallTextColor, fontSize: 12))
                                )
                              ],
                            ),
                          ) 
                        ],
                      ),
                    ),
                  ),
                 //Ví momo
                  Container(
                    height: 70,
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyBorder),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),                        
                    child: SizedBox(
                      width: myWidth,
                      height: 70,
                      child: Row(
                        children: [
                          //ảnh
                          SizedBox(
                            width: myWidth*0.3,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xfff9fafb),
                                shape: BoxShape.circle,
                              ),   
                              child: SizedBox(height: 30,width: 30, child: Image.asset("assets/momo.png", fit: BoxFit.cover,), )
                            ),
                          ),                         
                          //text 
                          SizedBox(
                            height: 70,
                            width: myWidth*0.6,
                            child: Column(
                              children: [
                                SizedBox(height: 12,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Ví điện tử Momo", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                ),
                                SizedBox(height: 3,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Một chạm", style: TextStyle(color: smallTextColor, fontSize: 12))
                                )
                              ],
                            ),
                          ) 
                        ],
                      ),
                    ),
                  ),
                  //ZaloPay
                  Container(
                    height: 70,
                    width: myWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyBorder),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),                        
                    child: SizedBox(
                      width: myWidth,
                      height: 70,
                      child: Row(
                        children: [
                          //ảnh
                          SizedBox(
                            width: myWidth*0.3,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xfff9fafb),
                                shape: BoxShape.circle,
                              ),   
                              child: SizedBox(height: 30,width: 30, child: Image.asset("assets/zalopay.png", fit: BoxFit.cover,), )
                            ),
                          ),                         
                          //text 
                          SizedBox(
                            height: 70,
                            width: myWidth*0.6,
                            child: Column(
                              children: [
                                SizedBox(height: 12,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Ví điện tử Zalopay", style: TextStyle(color: bigTextColor, fontSize: 16, fontWeight: FontWeight.w500),)
                                ),
                                SizedBox(height: 3,),
                                SizedBox(
                                  width: myWidth*0.6,
                                  child: Text("Một chạm", style: TextStyle(color: smallTextColor, fontSize: 12))
                                )
                              ],
                            ),
                          ) 
                        ],
                      ),
                    ),
                  ),

                ]
              ),
            )
          ]
        ),

      ),
    );
  }
}