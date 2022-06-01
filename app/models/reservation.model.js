const sql = require("./writeDB.js");

// 생성자 
const Reservation = function(reservations){
    this.departure = reservations.departure;
    this.destination = reservations.destination;
    this.date = reservations.date;
    this.user_name = reservations.user_name;
};

// reservation 튜플 추가 
Reservation.create = (newReservation, result)=>{
    sql.query("INSERT INTO reservations SET ?", newReservation, (err, res)=>{
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }
        

        console.log("Created reservation: ",{id:res.reservationId, ...newReservation });
        result(null, {id: res.reservationId, ...newReservation});

    });
};


// reservation id로 조회
Reservation.findByID = (reservationId, result)=>{
    sql.query('SELECT * FROM reservations WHERE id = ?',reservationId, (err, res)=>{
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }

        if(res.length){
            console.log("found reservation: ", res[0]);
            result(null, res[0]);
            return;
        }

        // 결과가 없을 시 
        result({kind: "not_found"}, null);
    });
};

// reservation 전체 조회
Reservation.getAll = result =>{
    sql.query('SELECT * FROM reservations', (err, res)=>{
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }

        console.log("reservation: ", res);
        result(null, res);
    });
};



module.exports = Reservation;
