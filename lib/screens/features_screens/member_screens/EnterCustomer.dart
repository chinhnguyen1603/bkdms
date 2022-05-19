import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/screens/features_screens/member_screens/ScanItem.dart';
import 'package:bkdms/services/ConsumerProvider.dart';


class EnterCustomer extends StatefulWidget {
  const EnterCustomer({ Key? key }) : super(key: key);

  @override
  State<EnterCustomer> createState() => _EnterCustomerState();
}

class _EnterCustomerState extends State<EnterCustomer> {

  bool checkPhone = false;
  bool isShowNameField = false;


  var darkGrey = Color(0xff544C4C); // màu xám
  
  final _formInputKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthDevice = 100.w;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,"Nhập khách hàng"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formInputKey,
            child: Column(
              children: [
                  SizedBox(height: 100),
                  //chứa form số điện thoại
                  SizedBox(
                      height: 55,
                      width: myWidth,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          cursorHeight: 23,
                          cursorColor: darkGrey,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 16, color: Color(0xff722828)),
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                  return 'Bạn chưa điền số diện thoại';
                              }
                              return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_android),
                              fillColor: Color(0xffE2DDDD),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Color(0xffE2DDDD)),
                              ),
                              hintText: "Số điện thoại",
                              hintStyle: TextStyle(fontSize: 16.0, color: Color(0xff722828)),
                          ),
                        ),
                  ),
                  // 
                  SizedBox(height: 20,),
                  //
                  SizedBox(
                      height: 55,
                      width: myWidth,
                      // formfield tên
                      child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          cursorHeight: 23,
                          cursorColor: darkGrey,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontSize: 16, color: Color(0xff722828)),
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                  return 'Bạn chưa điền tên';
                              }
                              return null;
                          },                          
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.supervisor_account),
                              fillColor: Color(0xffE2DDDD),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Color(0xffE2DDDD)),
                              ),
                              hintText: "Họ và tên",
                              hintStyle: TextStyle(fontSize: 16.0, color: Color(0xff722828)),
                          ),
                      ),
                  )
              ],),
          ),
        ),
      ),

      //bottom bar chỉ hiện khi isShowBottom true, update ở trên
      bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [ BoxShadow(
                   color: Colors.grey,
                   blurRadius: 5.0,
                   spreadRadius: 0.0,
                   offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )],
              ),
              width: widthDevice,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(
                          width: widthDevice*0.8,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                //check form có null không
                                if (_formInputKey.currentState!.validate()){
                                  //set phone và note để tạo đơn hàng
                                  Provider.of<ConsumerProvider>(context, listen: false).setNameAndPhone(nameController.text, phoneController.text);                                  
                                  //move to scanitem
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScanItem()));
                                }
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiến hành tạo đơn", style: TextStyle(fontWeight: FontWeight.w600), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )              
    );
  }
}