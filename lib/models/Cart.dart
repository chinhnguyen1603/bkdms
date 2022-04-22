class Cart {
   late String id;
   late String quantity;
   late String unitId;
   late String agencyId;
   late Map unit;
   Cart({
     required this.id, 
     required this.quantity, 
     required this.unitId, 
     required this.agencyId, 
     required this.unit,
   });
}