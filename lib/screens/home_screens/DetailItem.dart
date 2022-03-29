import 'package:bkdms/screens/home_screens/DescribeItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/services/ItemProvider.dart';
import 'package:bkdms/models/Item.dart';

class DetailItem extends StatefulWidget {
  late Item myItem;
  late var baseUnit;
  late List<dynamic> switchUnit;
  late List<dynamic> listUnit;
  DetailItem(this.myItem, this.baseUnit, this.switchUnit, this.listUnit);

  @override
  State<DetailItem> createState() => DetailItemState();
}


class DetailItemState extends State<DetailItem> {

  static const lightGrey = Color(0xfffafafa);
  static const greyText = Color(0xff544c4c);
  //khởi tạo value của radio
  int value = -1;
  //giá từng đơn vị
  String unitPrice ="";
  // dropdown tên đơn vị
  String? btnSelectVal;
  List<String> unitName = [];

  @override
  void initState(){
    super.initState();
    for(var unit in widget.listUnit){
       unitName.add(unit['name']);
    }
    
  }



  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;// chiều rộng thiết bị
    double myWidth = widthDevice*0.9; // chiều rộng hàng ngoài cùng(tê, giá sp, thông tin chi tiết,...)
    //thêm dấu chấm vào giá sản phẩm
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    // tạo dropdown button chứa unit name
    List<DropdownMenuItem<String>> createList() {
     return unitName
      .map<DropdownMenuItem<String>>(
         (e) => DropdownMenuItem(
             value: e,
             child: Text("$e"),
         ),
      )
      .toList();
    }

    //widget của screen
    return Scaffold(
      appBar: AppBarGrey("Chi tiết sản phẩm"),
      backgroundColor: Color(0xfff0ecec),
      body: Consumer<ItemProvider>( builder: (ctxItemProvider, itemProvider, child) {
        
        return SingleChildScrollView( 
          child: Center(
            child: Column(
                children: [
                  // container đầu chứa ảnh + tên + VAT
                  Container(
                    height: 280,
                    width: widthDevice,
                    color: Colors.white,
                     child: Column(
                       children:[
                         //ảnh sản phẩm
                         Image.network(
                            getUrlFromLinkImg("${widget.myItem.linkImg}"),
                            width: widthDevice * 0.8,
                            height: 210,
                         ),
                         SizedBox(height: 10,),
                         // tên sản phẩm
                         SizedBox(
                            width: myWidth,
                            child: Text(
                              "${widget.myItem.name}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600,
                              ),
                          ),
                         ),
                         // VAT 8%
                         SizedBox(height: 5,),
                         SizedBox(
                            width: myWidth,
                            child: Text(
                              "VAT 8%",
                              style: TextStyle(
                                 fontSize: 16,
                                 fontWeight: FontWeight.w300,
                                 color: Color(0xfff53838),
                              ),
                          ),
                        )
                       ]
                     ),
                  ),
                  
                  // Container chứa giá sản phẩm
                  SizedBox(height: 12,),
                  Container(
                    width: widthDevice,
                    height: 220,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        // text giá sản phẩm
                        Container(
                          width: myWidth,
                          child: Text("Giá sản phẩm", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                        ),
                        SizedBox(height: 5,),
                        //text lưu ý giá sản phẩm đã bao gồm VAT
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Text("Lưu ý giá sản phẩm đã bao gồm VAT", style: TextStyle(color: greyText),),
                            ],
                          )  
                        ),
                        // Đơn vị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Đơn vị", style: TextStyle(color: greyText),),
                              ),
                              //Dropdown tên đơn vị đơn vị
                              SizedBox(
                                height: 35,
                                width: myWidth*0.35,
                                child: DropdownButton(
                                  items: createList(),
                                  hint: Text("Chọn đơn vị"),
                                  value: btnSelectVal, 
                                  onChanged: (newValue) {
                                     if(newValue!=null){
                                       setState(() {
                                         btnSelectVal = newValue as String;
                                         // lấy đơn giá của đơn vị
                                         for( var unit in widget.listUnit){
                                           if(newValue == unit['name']){
                                              unitPrice = unit['agencyPrice'];
                                           }
                                         }
                                       });
                                     }
                                  }
                                )
                              )
                            ],
                          )  
                        ),                        
                        // Đơn giá
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Đơn giá", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("${unitPrice.replaceAllMapped(reg, mathFunc)}" + " VND", style: TextStyle(fontWeight: FontWeight.w600),),
                              )
                            ],
                          )  
                        ),                        
                        // Giá bán lẻ đề nghị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Giá bán lẻ đề nghị", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("${widget.myItem.retailPrice.replaceAllMapped(reg, mathFunc)}" + " VND", style: TextStyle(fontWeight: FontWeight.w600),),
                              )
                            ],
                          )  
                        ),                        
                        // bảng quy đổi đơn vị
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Quy đổi đơn vị", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: GestureDetector(
                                  onTap: (){
                                     //bảng quy đổi đơn vị
                                     showDialog(
                           context: context, 
                           builder: (ctx1) => AlertDialog(
                           title: Text("Bảng quy đổi đơn vị", style: TextStyle(fontSize: 20),),
                           content: Container(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Tiêu đề bảng
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text("Đơn vị", style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Text("Quy đổi", style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text("Đơn vị cơ bản", style: TextStyle(fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                  // Đơn vị cơ bảng
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: Text("${widget.baseUnit['name']}", ),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        child: Text("1",),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text("X"),
                                      )
                                    ],
                                  ),                                  
                                  //List view đơn vị chuyển đổi
                                  SizedBox(
                                    width: 240,
                                    height: 36,
                                    child: ListView.builder( 
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.switchUnit.length,
                                    itemBuilder:  (context, index) => SizedBox( 
                                      width: 240,
                                      child: Row( children: [
                                         SizedBox(
                                           width: 60,
                                           child: Text("${widget.switchUnit[index]['name']}", ),
                                         ),
                                         SizedBox(
                                           width: 80,
                                           child: Text("${widget.switchUnit[index]['switchRate']}",),
                                         ),
                                         SizedBox(
                                           width: 100,
                                           child: Text(""),
                                         )
                                        ],),
                                      )
                                   )
                                  )
                             ],)
                           ),
                           
                    
                           actions: [TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Center (child: const Text(
                                'OK',
                                 style: TextStyle(decoration: TextDecoration.underline,),
                              ),)
                              ),                      
                             ],                                      
                         ));
                                  }, 
                                  child: Text("xem ở đây", style: TextStyle(color: Colors.blue),),
                                ),
                              )
                            ],
                          )  
                        ),                        
                                      
                      ],
                    ),
                  ),
                
                  // Container chứa thông tin chi tiết
                  SizedBox(height: 12,),
                  Container(
                    width: widthDevice,
                    height: 180,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        // text thông tin chi tiết
                        Container(
                          width: myWidth,
                          child: Text("Thông tin chi tiết", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                        ),
                        SizedBox(height: 5,),
                        //Danh mục
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Danh mục", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("${widget.myItem.category?['name']}"),
                              )
                            ]
                          )  
                        ),
                        // Xuất xứ
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Xuất xứ", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("${widget.myItem.countryProduce}"),
                              )                              
                            ],
                          )  
                        ),                        
                        // Thương hiệu
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          color: lightGrey,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Ngày sản xuất", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: Text("${widget.myItem.dateManufacture}"),
                              )
                            ],
                          )  
                        ),                        
                        // Mô tả sản phẩm
                        Container(
                          width: myWidth*0.9,
                          height: 35,
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              SizedBox(
                                width: myWidth*0.35,
                                child: Text("Mô tả sản phẩm", style: TextStyle(color: greyText),),
                              ),
                              SizedBox(
                                width: myWidth*0.5,
                                child: GestureDetector(
                                  onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => DescribeItem(widget.myItem.description)));
                                  }, 
                                  child: Text("xem ở đây", style: TextStyle(color: Colors.blue),),
                                ),
                              )
                            ],
                          )  
                        ),          
                      ],
                    ),
                  )
 
                ],
            )
          )
        );
      }),
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
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ScanItem()));
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all < Color > (Color(0xff4690FF)),
                                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), )
                                  )
                              ),
                              child: Text("Chọn mua", style: TextStyle(fontWeight: FontWeight.w700), )
                          )  
                        ),
                        SizedBox(height: 7,),
                      ])
              )          
    );
  }

  // hàm lấy ảnh từ cloudinary
  String getUrlFromLinkImg(String linkImg) {
        final cloudinary = Cloudinary("975745475279556", "S9YIG_sABPRTmZKb0mGNTiJsAkg", "di6dsngnr");
        //linkImg receive from server as Public Id
        final cloudinaryImage = CloudinaryImage.fromPublicId("di6dsngnr", linkImg);
        String transformedUrl = cloudinaryImage.transform().width(256).thumb().generate()!;
        return transformedUrl;
  }
}