class Task {
  /*=================[Variables]===============*/
  static const String collectionName='tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  /*========================================*/

  // Constructor
  Task({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.isDone,
  });

  // Named Constructor
  Task.fromFireStore(Map<String, dynamic> data){
    id = data['id'];
    title= data['title'];
    description= data['description'];
    dateTime=DateTime.fromMillisecondsSinceEpoch(data['dateTime']);
    isDone= data['isDone'];
  }



  /*=================[Methods]===============*/
  Map<String,dynamic>toFireStore(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'dateTime':dateTime?.millisecondsSinceEpoch, // converted to int value
      'isDone':isDone
    };
  }
/*========================================*/

}
