import 'dart:developer';
import 'package:bkdms/models/Agency.dart';
import 'package:bkdms/services/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:bkdms/screens/home_screens/DetailItem.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';
import 'package:bkdms/models/CountBadge.dart';
import 'package:bkdms/screens/home_screens/ScreenCart.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class ShowListItem extends StatefulWidget {
  const ShowListItem({ Key? key }) : super(key: key);

  @override
  State<ShowListItem> createState() => ShowListItemState();
}



class ShowListItemState extends State<ShowListItem> {
 
  static const darkGrey = Color(0xff544C4C); 
  //search bar
  FloatingSearchBarController? searchController;
  List<Item> searchList = [];
  bool _isSearching = false;
  
  //biến dưới đây được dùng trong bottom sheet
  //giá từng đơn vị
  String unitPrice ="";
  //dropdown tên đơn vị
  String? btnSelectVal;
  //id của đơn vị
  int unitId = 0;
  //form nhập số lượng sản phẩm
  final _formEnterAmountKey = GlobalKey<FormState>();
  final enternAmountController = TextEditingController();
  
  //số mặt hàng trong giỏ, init = 0, update trong didChangeDependencies
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _isSearching = false;
     //mặc định searchList phải bằng lstItem để auto hiện khi xóa search
  } 
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    counter = Provider.of<CountBadge>(context).counter;
  }



  @override
  Widget build(BuildContext context) {
    //int counter = Provider.of<CountBadge>(context).counter;// khởi tạo counter là số mặt hàng trong cart 
    double heigtDevice = MediaQuery.of(context).size.height;// chiều cao thiết bị
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double widthContainerItem = widthDevice*0.4;
    double myWidth = widthDevice*0.9; // chiều rộng hàng ngoài cùng(tê, giá sp, thông tin chi tiết,...)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: darkGrey,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Badge(
             position: BadgePosition.topEnd(top: 0, end: 3),
             animationDuration: Duration(milliseconds: 300),
             animationType: BadgeAnimationType.slide,
             badgeContent: Text(
                counter.toString(),
                style: TextStyle(color: Colors.white),
             ),
             child: IconButton(
               icon: Icon(Icons.shopping_cart, color: darkGrey,), 
               onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenCart()));
               }
             ),
          )
        ], 
        centerTitle: true,
        title: Text(
            "Sản phẩm",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkGrey,),
        )
      ),
      backgroundColor: Color(0xfff0ecec),
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {  
        return SingleChildScrollView(

         child: Center(
          child: Column(
          children: [
            SizedBox(height: 20,),

            // SizedBox Search
            SizedBox(
              height: 100,
              child: Center(
                child: FloatingSearchBar(
                    controller: searchController,
                    hint: 'Tìm kiếm',
                    width: widthDevice*0.8,
                    height: 40,
                    backdropColor: Color(0xfff0ecec),
                    borderRadius: BorderRadius.circular(20),
                    onQueryChanged: (query) {
                       // Call your model, bloc, controller here.
                      setState(() {
                         searchList = itemProvider.lstItem
                                  .where((element) =>
                                     element.name.toLowerCase().contains(query.toLowerCase()) ||
                                     element.retailPrice.toLowerCase().contains(query.toLowerCase()))
                                  .toList();                
                         _isSearching = true;
                      });
                    },
                      // Specify a custom transition to be used for
                      // animating between opened and closed stated.
                    builder: (context, transition) { 
                       return Container(
                       );
                    },
                )
              ),
            ),
            
            //GridView Item
            SizedBox(
              height: 1500,
              width: widthDevice*0.98,
              child: _isSearching
              // Mặc định là false nên trả về dấu 2 chấm trước dấu hỏi. Đang search thì trả về dấu hỏi
              //Grid View của dấu hỏi là của searchList
              ?  GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: searchList.length,
                itemBuilder: (BuildContext ctxGridview, int index) {
                    //thêm dấu chấm vào giá sản phẩm
                    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                    
                    // List tên đơn vị của mỗi sản phẩm
                    final List<String> uName =  List<String>.generate(itemProvider.lstItem[index].units.length, (count) => "${itemProvider.lstItem[index].units[count]['name']}");
                    uName.add("");
                    List<DropdownMenuItem<String>> createList() {
                        return uName
                            .map<DropdownMenuItem<String>>( 
                               (e) => DropdownMenuItem(
                                 value: e,
                                 child: Text("$e", style: TextStyle(fontSize: 14),),
                               ),
                            )
                            .toList();
                    } 
                
                    //Xử lý đơn vị và chuyển đơn vị                                    
                    var baseUnit;
                    List<dynamic> switchUnit = [];
                    for(var unit in itemProvider.lstItem[index].units){
                        if(unit['isBaseUnit'] == true) {
                          baseUnit = unit;
                        } else {
                          switchUnit.add(unit);
                        }
                    }
                                   
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(searchList[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${searchList[index].linkImg}"),
                                            width: widthDevice*0.38, 
                                            height: widthDevice * 0.38,                    
                                       ),
                                    ),
                                    SizedBox(height: 10, ),
                                    //Tên sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(searchList[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                        },
                                        child: SizedBox(
                                            height: 28 ,
                                            width: widthContainerItem,
                                            child: Text(
                                               "${searchList[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency + icon addCart
                                    SizedBox(
                                        height: 20,
                                        width: widthContainerItem,
                                        child: Row(
                                          children: [
                                             // Price baseUnit Agency
                                             SizedBox(
                                               height: 20,
                                               width: widthContainerItem*0.8,
                                               child: Text(
                                                 "${baseUnit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + 'đ',
                                                 style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                               ),
                                             ),
                                             // icon add cart
                                             GestureDetector(
                                               //Show modal bottom sheet khi nhấn vào icon add cart
                                               onTap: (){
                                                  // để người dùng thêm vào giỏ hàng
                                                  showModalBottomSheet<void>(
                                                     isDismissible: false,
                                                     useRootNavigator: true,
                                                     backgroundColor: Colors.white,
                                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(10), topRight:  Radius.circular(10)),),
                                                     context: ctxGridview,
                                                     builder: (BuildContext context) {
                                                       return StatefulBuilder( builder: (BuildContext context, setState) =>
                                                        Container(
                                                           height: 320,
                                                           child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: <Widget>[
                                                                // icon button xóa 
                                                                SizedBox(
                                                                  width: widthDevice,
                                                                  height: 30,
                                                                  child: IconButton(
                                                                    icon: Icon(Icons.cancel_presentation, size: 20,),
                                                                    alignment: Alignment.centerRight,
                                                                    onPressed: () {
                                                                       setState(() {              
                                                                          btnSelectVal = ""; //set value của dropdowm về ""
                                                                       });
                                                                       Navigator.pop(context);
                                                                    },
                                                                  ),
 
                                                                ),
                                                                SizedBox(height: 5,),
                                                                
                                                                // ảnh sp + tên + + xuất xứ + giá 
                                                                Container(
                                                                   width: myWidth,
                                                                   height: 80,
                                                                   child: Row(children: [
                                                                     SizedBox(width: 10,),
                                                                      //Ảnh sản phẩm
                                                                      SizedBox(
                                                                         height: 100,
                                                                         width: myWidth*0.3,
                                                                         child: Image.network(
                                                                             getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}")
                                                                         ),
                                                                      ),
                                                                      SizedBox(width: 10,),
                                                                      //Tên, xuất xứ và giá
                                                                      SizedBox(
                                                                         height: 100,
                                                                         width: myWidth*0.6,
                                                                         child: Column(
                                                                             children: [
                                                                                // tên sản phẩm
                                                                                SizedBox(
                                                                                    height: 30,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                       "${itemProvider.lstItem[index].name}", 
                                                                                       maxLines: 1,
                                                                                       overflow: TextOverflow.ellipsis,
                                                                                       softWrap: false,
                                                                                       textAlign: TextAlign.left,
                                                                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),                                        
                                                                                    )
                                                                                ),
                                                                                // Xuất xứ
                                                                                SizedBox(
                                                                                    height: 24,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "Xuất xứ: " + "${itemProvider.lstItem[index].countryProduce}", 
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 12, ),                                        
                                                                                    )
                                                                                ),                                                                     
                                                                                // giá bán cho đại lý
                                                                                SizedBox(
                                                                                    height: 20,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "${unitPrice.replaceAllMapped(reg, mathFunc)}" + "đ", 
                                                                                      maxLines: 1,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                                                                    )
                                                                                ),                                    
                                                                             ],),
                                                                      )
                                                                  ]),
                                                                ),
                                                                
                                                                Divider(),
                                                                
                                                                //text lưu ý xem quy đổi
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                   SizedBox(width: widthDevice*0.1,),
                                                                   SizedBox(
                                                                     child: Text("Xem quy đổi đơn vị ở chi tiết mỗi sản phẩm", style: TextStyle(color: darkGrey, fontSize:14, fontFamily: "SegoeScript"),),
                                                                   ),
                                                                  ])
                                                                ),
                                                                SizedBox(height: 10,),
                                                                // chọn đơn vị
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    // text chọn vị
                                                                    SizedBox(
                                                                      width: myWidth*0.6,
                                                                      height: 30,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 8,),
                                                                          SizedBox(height: 20,width: myWidth*0.6, child: Text("Đơn vị", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                          SizedBox(height: 2,),
                                                                        ],
                                                                      )
                                                                    ),
                                                                   // dropdown button
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 60,
                                                                      child: DropdownButton(
                                                                         items: createList(),
                                                                         value: btnSelectVal, // giá trị khi select
                                                                         onChanged: (newValue) {
                                                                            if(newValue!=null){
                                                                               // lấy đơn giá của đơn vị
                                                                               for( var unit in itemProvider.lstItem[index].units){
                                                                                   if(newValue == unit['name']){
                                                                                       setState(() {
                                                                                          unitPrice = unit['agencyPrice'];
                                                                                          btnSelectVal = newValue as String;
                                                                                          unitId = unit['id'];
                                                                                       });
                                                                                   }
                                                                               }
                                                                            }
                                                                         }
                                                                      ) 
                                                                    ),
                                                                  ]),
                                                                ),
                                                                SizedBox(height: 10,),       
                                                                //Nhập số lượng
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    // text nhập số lượng
                                                                    SizedBox(
                                                                      width: myWidth*0.6,
                                                                      height: 30,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 8,),
                                                                          SizedBox(height: 20,width: myWidth*0.6, child: Text("Nhập số lượng", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                          SizedBox(height: 2,),
                                                                        ],
                                                                      )
                                                          
                                                                    ),
                                                                    //text formfield điền số lượng hàng
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 60, 
                                                                      child: Form(
                                                                        key: _formEnterAmountKey,
                                                                        child: TextFormField(
                                                                          controller: enternAmountController,        
                                                                          keyboardType: TextInputType.number,
                                                                          cursorHeight: 14,
                                                                          textAlignVertical: TextAlignVertical.center,
                                                                          style: TextStyle(fontSize: 12),
                                                                          validator: (value) {
                                                                             if (value == null || value.isEmpty) {
                                                                                return "trống";
                                                                             }
                                                                             return null;
                                                                          },  
                                                                          decoration:  InputDecoration(
                                                                             enabledBorder:  OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0),
                                                                                borderSide: BorderSide(color: darkGrey),
                                                                             ),
                                                                          )
                                                                        ),
                                                                      ),
                                                                   )
                                                                  ])
                                                                ),
                                                                Divider(),
                                                                //button thêm vào giỏ
                                                                SizedBox(height: 5,),
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    Container(
                                                                      height: 50,
                                                                      width: widthDevice*0.8,
                                                                      child: ElevatedButton(
                                                                        
                                                                        onPressed: () async {
                                                                          //post api add cart tại đây
                                                                           if (_formEnterAmountKey.currentState!.validate()){
                                                                              await showDialog (
                                                                                 context: context,
                                                                                 builder: (context) =>
                                                                                    FutureProgressDialog(getFuture(), message: Text('Thêm vào giỏ...', style: TextStyle(color:Color(0xffe2dddd)))),
                                                                              );
                                                                              setState(() {              
                                                                                  btnSelectVal = ""; //set value của dropdowm về ""
                                                                              });
                                                                              Navigator.pop(context);
                                                                           }
                                                                        },
                                                                        child: Text("Thêm vào giỏ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                                                        style: ButtonStyle(
                                                                            elevation: MaterialStateProperty.all(0),
                                                                            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                                )

                                                             ],
                                                           ),
                                                        ) );
                                                      },//builder
                                                  );//showmodal bottom sheet
                                               },
                                               child: Container(
                                                  height: 20,
                                                  width: widthContainerItem*0.2,
                                                  child: Icon(Icons.add_shopping_cart_sharp, size: 19, color: Color(0xff7b2626),),
                                               ),
                                             )
                                          ]
                                        )
                                    ),
                                ]
                            )
                        );
                },
        
               
              )          

              //Không search thì trả về nguyên mẫu. Gridview của lstItem
              : GridView.builder(              
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1/1.2,
                ),
                padding: EdgeInsets.all(8),
                primary: false,
                itemCount: itemProvider.lstItem.length,
                itemBuilder: (BuildContext ctxGridview, int index) {
                    // thêm dấu chấm vào giá sản phẩm 
                    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
                   
                    // List tên đơn vị của mỗi sản phẩm
                    final List<String> uName =  List<String>.generate(itemProvider.lstItem[index].units.length, (count) => "${itemProvider.lstItem[index].units[count]['name']}");
                    uName.add("");
                    List<DropdownMenuItem<String>> createList() {
                        return uName
                            .map<DropdownMenuItem<String>>( 
                               (e) => DropdownMenuItem(
                                 value: e,
                                 child: Text("$e", style: TextStyle(fontSize: 14),),
                               ),
                            )
                            .toList();
                    } 

                   
                    //Xử lý đơn vị và chuyển đơn vị
                    var baseUnit;
                    List<dynamic> switchUnit = [];
                    for(var unit in itemProvider.lstItem[index].units){
                        if(unit['isBaseUnit'] == true) {
                          baseUnit = unit;
                        } else {
                          switchUnit.add(unit);
                        }
                    }
                    return  Container(
                            color: Colors.white,
                            child: Column(
                                children: [
                                    // Ảnh sản phẩm
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                       },
                                        child: Image.network(
                                            getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}"),
                                            width: widthDevice*0.38,
                                            height: widthDevice * 0.38,                       
                                       ),
                                    ),
                                    //Tên sản phẩm
                                    SizedBox(height: 10, ),
                                    GestureDetector(
                                        onTap: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context) => DetailItem(itemProvider.lstItem[index],baseUnit,switchUnit,itemProvider.lstItem[index].units)));
                                        },
                                        child: SizedBox(
                                            height: 28 ,
                                            width: widthDevice*0.4,
                                            child: Text(
                                               "${itemProvider.lstItem[index].name}",
                                               maxLines: 2, 
                                               overflow: TextOverflow.ellipsis,
                                               softWrap: false,
                                               style: TextStyle(fontSize: 12),
                                        )
                                    ),),
                                    // Price Agency + icon addCart
                                    SizedBox(
                                        height: 20,
                                        width: widthContainerItem,
                                        child: Row(
                                          children: [
                                             // Price baseUnit Agency
                                             SizedBox(
                                               height: 20,
                                               width: widthContainerItem*0.8,
                                               child: Text(
                                                 "${baseUnit['agencyPrice'].replaceAllMapped(reg, mathFunc)}" + 'đ',
                                                 style: TextStyle(fontSize:16, color: Color(0xffb01313))
                                               ),
                                             ),
                                             // icon add cart
                                             GestureDetector(
                                               onTap: (){
                                                  showModalBottomSheet<void>(
                                                     isDismissible: false,
                                                     useRootNavigator: true,
                                                     backgroundColor: Colors.white,
                                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:  Radius.circular(10), topRight:  Radius.circular(10)),),
                                                     context: ctxGridview,
                                                     builder: (BuildContext context) {
                                                       return StatefulBuilder( builder: (BuildContext context, setState) =>
                                                        Container(
                                                           height: 320,
                                                           child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: <Widget>[
                                                                // icon button xóa 
                                                                SizedBox(
                                                                  width: widthDevice,
                                                                  height: 30,
                                                                  child: IconButton(
                                                                    icon: Icon(Icons.cancel_presentation, size: 20,),
                                                                    alignment: Alignment.centerRight,
                                                                    onPressed: () {
                                                                       setState(() {              
                                                                          btnSelectVal = ""; //set value của dropdowm về ""
                                                                       });
                                                                       Navigator.pop(context);
                                                                    },
                                                                  ),
 
                                                                ),
                                                                SizedBox(height: 5,),
                                                                
                                                                // ảnh sp + tên + + xuất xứ + giá 
                                                                Container(
                                                                   width: myWidth,
                                                                   height: 80,
                                                                   child: Row(children: [
                                                                     SizedBox(width: 10,),
                                                                      //Ảnh sản phẩm
                                                                      SizedBox(
                                                                         height: 100,
                                                                         width: myWidth*0.3,
                                                                         child: Image.network(
                                                                             getUrlFromLinkImg("${itemProvider.lstItem[index].linkImg}")
                                                                         ),
                                                                      ),
                                                                      SizedBox(width: 10,),
                                                                      //Tên, xuất xứ và giá
                                                                      SizedBox(
                                                                         height: 100,
                                                                         width: myWidth*0.6,
                                                                         child: Column(
                                                                             children: [
                                                                                // tên sản phẩm
                                                                                SizedBox(
                                                                                    height: 30,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                       "${itemProvider.lstItem[index].name}", 
                                                                                       maxLines: 1,
                                                                                       overflow: TextOverflow.ellipsis,
                                                                                       softWrap: false,
                                                                                       textAlign: TextAlign.left,
                                                                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),                                        
                                                                                    )
                                                                                ),
                                                                                // Xuất xứ
                                                                                SizedBox(
                                                                                    height: 24,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "Xuất xứ: " + "${itemProvider.lstItem[index].countryProduce}", 
                                                                                      maxLines: 1,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      softWrap: false,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 12, ),                                        
                                                                                    )
                                                                                ),                                                                     
                                                                                // giá bán cho đại lý
                                                                                SizedBox(
                                                                                    height: 20,
                                                                                    width: myWidth*0.6,
                                                                                    child: Text(
                                                                                      "${unitPrice.replaceAllMapped(reg, mathFunc)}" + "đ", 
                                                                                      maxLines: 1,
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(fontSize: 16, color: Color(0xffb01313), fontWeight: FontWeight.w500),                                        
                                                                                    )
                                                                                ),                                    
                                                                             ],),
                                                                      )
                                                                  ]),
                                                                ),
                                                                
                                                                Divider(),
                                                                
                                                                //text lưu ý xem quy đổi
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                   SizedBox(width: widthDevice*0.1,),
                                                                   SizedBox(
                                                                     child: Text("Xem quy đổi đơn vị ở chi tiết sản phẩm", style: TextStyle(color: darkGrey, fontSize:14,),),
                                                                   ),
                                                                  ])
                                                                ),
                                                                SizedBox(height: 10,),
                                                                // chọn đơn vị
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    // text chọn vị
                                                                    SizedBox(
                                                                      width: myWidth*0.6,
                                                                      height: 30,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 8,),
                                                                          SizedBox(height: 20,width: myWidth*0.6, child: Text("Đơn vị", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                          SizedBox(height: 2,),
                                                                        ],
                                                                      )
                                                                    ),
                                                                   // dropdown button
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 60,
                                                                      child: DropdownButton(
                                                                         items: createList(),
                                                                         value: btnSelectVal, // giá trị khi select
                                                                         onChanged: (newValue) {
                                                                            if(newValue!=null){
                                                                               // lấy đơn giá của đơn vị
                                                                               for( var unit in itemProvider.lstItem[index].units){
                                                                                   if(newValue == unit['name']){
                                                                                       setState(() {
                                                                                          unitPrice = unit['agencyPrice'];
                                                                                          btnSelectVal = newValue as String;
                                                                                          unitId = unit['id'];
                                                                                       });
                                                                                   }
                                                                               }
                                                                            }
                                                                         }
                                                                      ) 
                                                                    ),
                                                                  ]),
                                                                ),
                                                                SizedBox(height: 10,),       
                                                                //Nhập số lượng
                                                                SizedBox(
                                                                  height: 30,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    // text nhập số lượng
                                                                    SizedBox(
                                                                      width: myWidth*0.6,
                                                                      height: 30,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 8,),
                                                                          SizedBox(height: 20,width: myWidth*0.6, child: Text("Nhập số lượng", textAlign: TextAlign.left,style: TextStyle(color: darkGrey, fontSize: 14),),),
                                                                          SizedBox(height: 2,),
                                                                        ],
                                                                      )
                                                          
                                                                    ),
                                                                    //text formfield điền số lượng hàng
                                                                    SizedBox(
                                                                      height: 30,
                                                                      width: 60, 
                                                                      child: Form(
                                                                        key: _formEnterAmountKey,
                                                                        child: TextFormField(
                                                                          controller: enternAmountController,        
                                                                          keyboardType: TextInputType.number,
                                                                          cursorHeight: 14,
                                                                          textAlignVertical: TextAlignVertical.center,
                                                                          style: TextStyle(fontSize: 12),
                                                                          validator: (value) {
                                                                             if (value == null || value.isEmpty) {
                                                                                return "trống";
                                                                             }
                                                                             return null;
                                                                          },  
                                                                          decoration:  InputDecoration(
                                                                             enabledBorder:  OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(0),
                                                                                borderSide: BorderSide(color: darkGrey),
                                                                             ),
                                                                          )
                                                                        ),
                                                                      ),
                                                                   )
                                                                  ])
                                                                ),
                                                                Divider(),
                                                                //button thêm vào giỏ
                                                                SizedBox(height: 5,),
                                                                SizedBox(
                                                                  height: 50,
                                                                  width: widthDevice,
                                                                  child: Row(children: [
                                                                    SizedBox(width: widthDevice*0.1,),
                                                                    Container(
                                                                      height: 50,
                                                                      width: widthDevice*0.8,
                                                                      child: ElevatedButton(
                                                                        
                                                                        onPressed: () async {
                                                                          //post add cart, get cart và update CountBadge tại đây
                                                                           if (_formEnterAmountKey.currentState!.validate()){
                                                                              await showDialog (
                                                                                 context: context,
                                                                                 builder: (context)  =>
                                                                                    FutureProgressDialog(getFuture(), message: Text('Thêm vào giỏ...', style: TextStyle(color: Color(0xff7d7d7d)))),
                                                                              );                                                                      
                                                                              setState(() {              
                                                                                  btnSelectVal = ""; //set value của dropdowm về ""
                                                                              });
                                                                              Navigator.pop(context);
                                                                           }
                                                                        },
                                                                        child: Text("Chọn mua", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                                                        style: ButtonStyle(
                                                                            elevation: MaterialStateProperty.all(0),
                                                                            backgroundColor:  MaterialStateProperty.all<Color>(Color(0xff4690FF)),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ]),
                                                                )

                                                             ],
                                                           ),
                                                        ) );
                                                      },//builder
                                                  );//showmodal bottom sheet
                                                   
                                               },
                                               child: Container(
                                                  height: 20,
                                                  width: widthContainerItem*0.2,
                                                  child: Icon(Icons.add_shopping_cart_sharp, size: 19, color: Color(0xff7b2626),),
                                               ),
                                             )
                                          ]
                                        )
                                    ),
                                ]
                            )
                        );
                },
        
               
              )
              )                 
          ]
        ))
        
        );
      })
    );
    
  }
   
  // hàm lấy ảnh từ cloudinary 
  String getUrlFromLinkImg(String linkImg) {
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate() !;
        return transformedUrl;
  }   

  // hàm add cart rồi get, update số lượng sản phẩm
  Future getFuture() {
    return Future(() async {
      Agency user = Provider.of<Agency>(context, listen: false);
      await Provider.of<CartProvider>(context, listen: false).addCart(user.token, user.workspace, user.id, unitId, enternAmountController.text)
     .catchError((onError) async {
          // Alert Dialog khi lỗi xảy ra
          print("Bắt lỗi future dialog");
          await showDialog(
              context: context, 
              builder: (ctx1) => AlertDialog(
                  title: Text("Oops! Có lỗi xảy ra", style: TextStyle(fontSize: 24),),
                  content: Text("$onError"),
                  actions: [TextButton(
                      onPressed: () => Navigator.pop(ctx1),
                      child: Center (child: const Text('OK', style: TextStyle(decoration: TextDecoration.underline,),),)
                  ),                      
                  ],                                      
              ));    
            throw onError;          
      })
      .then((value) async {
          //get cart và update CountBadge
          await Provider.of<CartProvider>(context, listen: false).getCart(user.token, user.workspace, user.id);
          Provider.of<CountBadge>(context, listen: false).setCounter(Provider.of<CartProvider>(context, listen: false).lstCart.length);   
      });    
    });
  }   
}