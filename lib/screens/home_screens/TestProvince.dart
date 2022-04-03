import 'package:bkdms/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:bkdms/screens/home_screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:bkdms/services/ProvinceProvider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TestProvince extends StatefulWidget {
  const TestProvince({ Key? key }) : super(key: key);

  @override
  State<TestProvince> createState() => TestProvinceState();
}


class TestProvinceState extends State<TestProvince> {
  static const darkGrey = Color(0xff544C4C);
  //list tỉnh
  List<Province> lstProvince = [];
  //dropdown tỉnh 
  String? btnSelectPronvince;
  //id tỉnh khi user chọn
  int idProv = 0;

  //list quận huyện
  List<District> lstDistrict = [];
  //dropdown huyện 
  String? btnSelectDistrict;
  //id huyện khi user chọn
  int idDistrict = 0;

  //list xã phường
  List<Ward> lstWard = [];
  //dropdown xã phường
  String? btnSelectWard;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lstProvince = Provider.of<ProvinceProvider>(context).lstProvince;
    lstDistrict = Provider.of<ProvinceProvider>(context).lstDistrict; 
    lstWard = Provider.of<ProvinceProvider>(context).lstWard; 
    final List<String> lstNameDistrict =  List<String>.generate(lstDistrict.length, (index) => "${lstDistrict[index].name}");
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
  }
  
  @override
  void initState() {    
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    // List tên tỉnh + menu item dropdown district
    final List<String> lstNameProvince =  List<String>.generate(lstProvince.length, (index) => "${lstProvince[index].name}");
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
    // List tên huyện + menu item dropdown district
    final List<String> lstNameDistrict =  List<String>.generate(lstDistrict.length, (index) => "${lstDistrict[index].name}");
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
    // List tên xã phường + menu item dropdown ward
    final List<String> lstNameWard =  List<String>.generate(lstWard.length, (index) => "${lstWard[index].name}");
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
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: darkGrey,),
          onPressed: (){
              Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
            "Test Chọn địa chỉ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: darkGrey,
            ),
        )
      ), 
      backgroundColor: Color(0xffF0ECEC), // background color của màn hình
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            // dropdown button Tỉnh
            SizedBox(
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
                      for( var prov in lstProvince){
                        // lấy id của Tỉnh mới chọn
                        if(btnSelectPronvince == prov.name){
                            idProv = prov.id;
                        }
                      }
                    });   
                    await Provider.of<ProvinceProvider>(context, listen: false).getDistrict(idProv);                                                   
                  }
              ) 
            ),
            SizedBox(height: 10,),
            // dropdown button Huyện
            SizedBox(
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
                  onChanged: (newValue)  {
                    setState(() async {
                      for( var distr in lstDistrict){
                        // lấy id của Huyện mới chọn
                        if(newValue == distr.name){
                            idDistrict = distr.id;
                        }
                      }
                      await Provider.of<ProvinceProvider>(context, listen: false).getWard(idDistrict); 
                      btnSelectDistrict= newValue as String;
                    });     
                                                       
                  }
              ) 
            ),
            SizedBox(height: 10,),
            // dropdown button xã phường
            SizedBox(
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
 
         ],
        ),
      ),
      //bottom button chọn mua
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
                          width: widthDevice*0.9,
                          height: 40,
                          //button tiến hành đặt hàng
                          child: ElevatedButton(
                              onPressed: () async {
                                  await Provider.of<ProvinceProvider>(context, listen: false).getProvince();
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Tiến hành đặt hàng", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          

    );
  }


}