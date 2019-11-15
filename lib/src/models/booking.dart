class Booking {
  String id;
  String ticketnumber;
  String restroname;
  String userid;
  String restaurantid;
  String phonenumber;
  String email;
  String username;
  String date;
  String time;
  String status;

  Booking(
      {this.id,
      this.ticketnumber,
      this.restroname,
      this.userid,
      this.restaurantid,
      this.phonenumber,
      this.email,
      this.username,
      this.date,
      this.time,
      this.status});

  Booking.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    ticketnumber = json['ticketnumber'];
    restroname = json['restroname'];
    userid = json['userid'];
    restaurantid = json['restaurantid'];
    phonenumber = json['phonenumber'];
    email = json['email'];
    username = json['username'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
  }
}
