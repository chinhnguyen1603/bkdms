import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/components/AppBarTransparent.dart';
import 'package:bkdms/services/ProvinceProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sizer/sizer.dart';

class TestProvince extends StatefulWidget {
  const TestProvince({ Key? key }) : super(key: key);

  @override
  State<TestProvince> createState() => TestProvinceState();
}


class TestProvinceState extends State<TestProvince> {
  static const darkGrey = Color(0xff544C4C);
  //list tỉnh
  List<Province> lstProvince = [];
  //Value select tỉnh 
  String? btnSelectPronvince;
  //id tỉnh khi user chọn
  int idProv = 0;

  //list quận huyện
  List<District> lstDistrict = [];
  //Value select huyện 
  String? btnSelectDistrict;
  //id huyện khi user chọn
  int idDistrict = 0;

  //list xã phường
  List<Ward> lstWard = [];
  //Value xã phường
  String? btnSelectWard;
  
  //create list dropdown
  List<String> lstNameProvince  = [];
  List<String> lstNameDistrict = [];
  List<String> lstNameWard = [];

  // form extraOfAddress
  final extraController = TextEditingController();  
  final _formExtraKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lstProvince = Provider.of<ProvinceProvider>(context).lstProvince;
    lstNameProvince =  List<String>.generate(lstProvince.length, (index) => "${lstProvince[index].name}");
    lstNameProvince.add("");

    lstDistrict = Provider.of<ProvinceProvider>(context).lstDistrict; 
    lstNameDistrict =  List<String>.generate(lstDistrict.length, (index) => "${lstDistrict[index].name}");
    lstNameDistrict.add("");

    lstWard = Provider.of<ProvinceProvider>(context).lstWard; 
    lstNameWard =  List<String>.generate(lstWard.length, (index) => "${lstWard[index].name}"); 
    lstNameWard.add("");
  }
  
    // List tên tỉnh + menu item dropdown district
    List<DropdownMenuItem<String>> createListProvince() {
        return lstNameProvince
          .map<DropdownMenuItem<String>>( 
             (e) => DropdownMenuItem(
                value: e,
                child: Text("$e", style: TextStyle(fontSize: 14),),
              ),
          )
          .toList();
    } 

    List<DropdownMenuItem<String>> createListDistrict() {
        return lstNameDistrict
          .map<DropdownMenuItem<String>>( 
             (e) => DropdownMenuItem(
                value: e,
                child: Text("$e", style: TextStyle(fontSize: 14),),
              ),
          )
          .toList();
    }    

    List<DropdownMenuItem<String>> createListWard() {
        return lstNameWard
          .map<DropdownMenuItem<String>>( 
             (e) => DropdownMenuItem(
                value: e,
                child: Text("$e", style: TextStyle(fontSize: 14),),
              ),
          )
          .toList();
    }         
     

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarTransparent(Color(0xfffcfcfc), "Địa chỉ"),
      backgroundColor: Color(0xfffcfcfc), // background color của màn hình
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
              width: 100.w,
              height: 10,
            ),
            // text tỉnh thành
            SizedBox(
              width: 90.w,
              child: Text("Tỉnh, Thành", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 5,),
            // dropdown button Tỉnh
            SizedBox(
             width: 90.w,
             child: DropdownButtonHideUnderline(
               child: DropdownButton2(
                  isExpanded: true,
                  dropdownMaxHeight: 250,
                  items: createListProvince(),
                  value: btnSelectPronvince, // giá trị khi select
                  buttonHeight: 45,
                  buttonWidth: 200,
                  hint: Text("Chọn tỉnh"),
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(
                        color: Color(0xff544c4c),
                     ),
                  color: Colors.white,
                  ),                                                       
                  onChanged: (newValue) async {
                    setState(() {
                      btnSelectPronvince = newValue as String; 
                      btnSelectDistrict = ""; //set huyện xã bằng null lại
                      btnSelectWard = "";
                      for( var prov in lstProvince){
                        // lấy id của Tỉnh mới chọn
                        if(newValue == prov.name){
                            idProv = prov.id;
                        }
                      }
                    });   
                    await Provider.of<ProvinceProvider>(context, listen: false).getDistrict(idProv);                                                   
                  }
                ) 
              ),
            ),
            SizedBox(height: 15,),
            // text quận huyện
            SizedBox(
              width: 90.w,
              child: Text("Quận, Huyện", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 5,),
            // dropdown button Huyện
            SizedBox(
              width: 90.w,
              child: DropdownButtonHideUnderline(
               child: DropdownButton2(
                  isExpanded: true,
                  dropdownMaxHeight: 250,
                  items: createListDistrict(),
                  value: btnSelectDistrict, // giá trị khi select
                  buttonHeight: 45,
                  buttonWidth: 200,
                  hint: Text("Chọn quận, huyện"),
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(
                        color: Color(0xff544c4c),
                     ),
                  color: Colors.white,
                  ),                                                       
                  onChanged: (newValue) async {
                    setState(() {
                      for( var distr in lstDistrict){
                        btnSelectDistrict= newValue as String;
                        btnSelectWard = ""; //set xã bằng null lại
                        // lấy id của Huyện mới chọn
                        if(newValue == distr.name){
                            idDistrict = distr.id;
                        }
                      }
                    });     
                    await Provider.of<ProvinceProvider>(context, listen: false).getWard(idDistrict);                          
                  }
               ) 
              )
            ),
            SizedBox(height: 15,),
            // text xã phường
            SizedBox(
              width: 90.w,
              child: Text("Xã, Phường", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 5,),
            // dropdown button xã phường
            SizedBox(
              width: 90.w,
              child: DropdownButtonHideUnderline(
               child: DropdownButton2(
                  isExpanded: true,
                  dropdownMaxHeight: 250,
                  items: createListWard(),
                  value: btnSelectWard, // giá trị khi select
                  buttonHeight: 45,
                  buttonWidth: 200,
                  hint: Text("Chọn phường, xã"),
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     border: Border.all(
                        color: Color(0xff544c4c),
                     ),
                  color: Colors.white,
                  ),                                                       
                  onChanged: (newValue) async {
                    setState(() {
                      btnSelectWard= newValue as String;
                    });                                               
                  }
              ) 
            ),
           ),
            SizedBox(height: 15,), 
            // text Thông tin thêm
            SizedBox(
              width: 90.w,
              child: Text("Thông tin thêm", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
            ),    
            SizedBox(height: 5,),         
            // form thông tin chi tiết
            SizedBox(
              height: 45,
              width: 90.w,
              child: Form(
                key: _formExtraKey,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorHeight: 24,
                    controller: extraController,
                    style: TextStyle(fontSize: 15),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                         return "Không được để trống";
                      }
                      return null;
                    },                 
                    decoration:  InputDecoration(
                      hintText: "Tên đường, số nhà...",
                      hintStyle: TextStyle(fontSize: 16),
                      fillColor: Colors.white, 
                      filled: true,
                      enabledBorder:  OutlineInputBorder(
                         borderRadius: BorderRadius.circular(5),
                         borderSide: BorderSide(color: Colors.black),
                      ),
                    ),   
                ),
              ),
            )
         ],
        ),
      ),
      //bottom button Lưu thông tin
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
              width: 100.w,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 7,),
                        SizedBox(
                          width: 90.w,
                          height: 40,
                          //button tiến hành đặt hàng
                          child: ElevatedButton(
                              onPressed: () {
                              if (_formExtraKey.currentState!.validate()){     
                                  Navigator.pop(context);
                                }
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xfff53838)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Lưu thông tin", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          

    );
  }


}