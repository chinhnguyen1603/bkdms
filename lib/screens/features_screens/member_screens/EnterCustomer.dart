import 'package:flutter/material.dart';
import 'package:bkdms/components/AppBarTransparent.dart';


class EnterCustomer extends StatefulWidget {
  const EnterCustomer({ Key? key }) : super(key: key);

  @override
  State<EnterCustomer> createState() => EnterCustomerState();
}

class EnterCustomerState extends State<EnterCustomer> {
  
  bool isShowBottom = false;
  bool isPressIcon = false;
  bool isShowText = false;
  bool checkPhone = false;
  bool isShowNameField = false;


  var darkGrey = Color(0xff544C4C); // màu xám
  
  final _formPhoneKey = GlobalKey<FormState>();
  final _formNameKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9;
    return Scaffold(
      appBar: AppBarTransparent(Colors.white,"Nhập khách hàng"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
                SizedBox(height: 100),
                // chứa form số điện thoại
                SizedBox(
                    height: 55,
                    width: widthDevice * 0.9,
                    // form số điện thoại
                    child: Form(
                      key: _formPhoneKey,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        cursorHeight: 23,
                        cursorColor: darkGrey,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 18, color: Color(0xff722828)),
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                                return 'Bạn chưa điền vào ô';
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
                            hintStyle: TextStyle(fontSize: 18.0, color: Color(0xff722828)),

                        ),
                      )
                    ),
                ),
                
                //icon và Text
                SizedBox(
                    width: myWidth,
                    child: Row(children: [
                        SizedBox(
                            width: myWidth * 0.09,
                            child: IconButton(
                                onPressed: () {
                                  // sdt không được null
                                  if (_formPhoneKey.currentState!.validate()){
                                    setState(() {
                                        isShowBottom = true;
                                        isPressIcon = true;
                                        isShowText = true;
                                    });
                                    if(2<1){
                                       //nếu if đúng thì checkPhone true để trả về tên user
                                       checkPhone = true;
                                    }else{
                                       //nếu if sai thì text sdt chưa tồn tại và show nameField
                                       isShowNameField = true;
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.verified_user,
                                  color: (isPressIcon)?Color(0xff4690FF):Color(0xff858282),
                                  size: 22,
                                )
                            ),
                        ),
                        // biến isShowtext để nếu nhấn vào icon button mới trả về text
                        (isShowText)
                        ?SizedBox(
                          width: myWidth*0.8,
                          child: (checkPhone)?Text("Nguyễn Văn An"):Text("SDT chưa tồn tại trong hệ thống"),
                        )
                        :Text(""),
                    ], )
                ),
                
                // nếu sdt không tồn tại thì hiện TextFormField điền tên
                (isShowNameField) 
                ?SizedBox(
                    height: 55,
                    width: widthDevice * 0.9,
                    // form tên
                    child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        cursorHeight: 23,
                        cursorColor: darkGrey,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 18, color: Color(0xff722828)),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.supervisor_account),
                            fillColor: Color(0xffE2DDDD),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Color(0xffE2DDDD)),
                            ),
                            hintText: "Họ và tên",
                            hintStyle: TextStyle(fontSize: 18.0, color: Color(0xff722828)),
                        ),

                    ),
                )
                :Text("")
            ],),
        ),
      ),

      //bottom bar chỉ hiện khi isShowBottom true, update ở trên
      bottomNavigationBar: isShowBottom 
      ? SizedBox(
              width: widthDevice * 0.7,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(),
                        SizedBox(
                          width: widthDevice*0.7,
                          height: 35,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiến hành tạo đơn", )
                          )  
                        ),
                        SizedBox(height: 5,),
                      ])
              )          
      :Text("")    
    );
  }
}