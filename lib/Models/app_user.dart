class AppUser{

   String? id , userName , userAddress,  userEmail, userPhone , userPassword , imageUrl ;
   bool? isAdmin = false ;


   AppUser( {this.id , required this.userName,required this.userAddress,required this.userEmail, required this.userPhone,this.isAdmin ,this.imageUrl});

  Map<String,dynamic> toMap(){
     return {
       "userName":userName,
       "userAddress":userAddress,
       "isAdmin":isAdmin,
       "userEmail":userEmail,
       "userPhone":userPhone,
       "imageUrl":imageUrl,
     };
   }


   AppUser.fromMap(Map<String,dynamic> map){
    id = map['id']?? ' ';
    userName = map['userName']?? ' ';
    userAddress = map['userAddress']?? ' ';
    isAdmin = map['isAdmin']?? false ;
    userEmail = map['userEmail']?? ' ';
    userPhone = map['userPhone']?? ' ';
    imageUrl = map['imageUrl']?? ' ';
   }

}