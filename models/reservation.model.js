const sql = require("./writeDB.js");

// 생성자 
const Reservation = function(reservations){
    this.user_name = reservations.user_name;
    this.departure = reservations.departure;
    this.destination = reservations.destination;
    this.date = reservations.date;
};

// reservation 튜플 추가 
Reservation.create = (newReservation, result)=>{
    sql.query("INSERT INTO reservations SET ?", newReservation, (err, res)=>{
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }

        console.log("Created reservation: ",{id:res.inseertId, ...newReservation });
        result(null, {id: res.inseertId, ...newReservation});
    });
};

// reservation id로 조회
Reservation.findByID = (reservationID, result)=>{
    sql.query('SELECT * FROM reservations WHERE id = ?',reservationID, (err, res)=>{
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


// reservation id로 삭제
Reservation.remove = (id, result)=>{
    sql.query('DELETE FROM reservations WHERE id = ?',id, (err, res)=>{
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }

        if(res.affectedRows ==0){
            // id 결과가 없을 시 
            result({kind: "not_found"}, null);
            return;
        }

        console.log("deleted reservation with id: ", id);
        result(null, res);
    });
};

module.exports = Reservation;
 
