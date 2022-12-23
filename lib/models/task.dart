// The individual todo item.
class Task {
  late String id;

  late String title;
  late bool done;
  late String doBefore; // DateTime
  late bool favorite;

  late int order;

  Task(
    this.id,
    this.title,
    this.done,
    this.doBefore,
    this.favorite,
    this.order,
  );

  Task.fromJson(Map<String, dynamic> json)
      : id = json["id"]! as String,
        title = json["title"]! as String,
        done = json["done"]! as bool,
        doBefore = json["doBefore"]! as String,
        favorite = json["favorite"]! as bool,
        order = json["order"]! as int;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "done": done,
      "doBefore": doBefore,
      "favorite": favorite,
      "order": order,
    };
  }
}
