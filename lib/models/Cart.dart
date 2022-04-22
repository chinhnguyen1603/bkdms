class Cart {
   late int id;
   late String quantity;
   late String unitId;
   late int agencyId;
   late Map unit;
   Cart({
     required this.id, 
     required this.quantity, 
     required this.unitId, 
     required this.agencyId, 
     required this.unit,
   });
}