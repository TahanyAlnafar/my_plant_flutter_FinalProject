
class Plant {
  String? id , plantName ,plantImage , plantWatering, plantLightning, plantDescription;

  Plant({
      this.id,
      this.plantName,
       this.plantImage,
       this.plantWatering,
       this.plantLightning,
       this.plantDescription,
  });

  toMap() {
    return {"plantName": plantName, "plantImage": plantImage, "plantDescription": plantDescription ,"plantLightning": plantLightning ,"plantDescription": plantDescription , };
  }

  Plant.fromMap(Map<String, dynamic> map) {
    id = map['id']?? ' ';
    plantName = map['plantName']?? ' ';
    plantImage = map['plantImage']?? ' ';
    plantWatering = map['plantWatering']?? ' ';
    plantLightning = map['plantLightning']?? ' ';
    plantDescription = map['plantDescription']?? ' ';
  }



}
