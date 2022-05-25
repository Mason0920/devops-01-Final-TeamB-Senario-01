const Reservation = require("../models/reservation.model.js");

// 새 객체 생성
exports.create = (req,res)=>{
    if(!req.body){
        res.status(404).send({
            message: "Invalid input"
        });
    };

    const reservation = new Reservation({
      departure: req.body.departure,
      destination: req.body.destination,
      date: req.body.date,
      user_name: req.body.user_name
    });
   
    // 데이터베이스에 저장
    Reservation.create(reservation, (err, data) =>{
        if(err){
            res.status(503).send({
                message:
                err.message || "Some errors occured while creating the Reservation."
            });
        };
    })
};

// 전체 조회 
exports.findAll = (req,res)=>{
    Reservation.getAll((err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Some error occurred while retrieving reservations."
          });
        else res.send(data);
      });
};

// id로 조회
exports.findOne = (req,res)=>{
    Reservation.findById(req.params.reservationId, (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Reservation with id ${req.params.reservationId}.`
            });
          } else {
            res.status(500).send({
              message: "Error retrieving Reservation with id " + req.params.reservationId
            });
          }
        } else res.send(data);
      });
};

// id로 삭제
exports.delete = (req,res)=>{
    Reservation.remove(req.params.reservationId, (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Reservation with id ${req.params.reservationId}.`
            });
          } else {
            res.status(500).send({
              message: "Could not delete Reservation with id " + req.params.reeservationId
            });
          }
        } else res.send({ message: `Reservation has been deleted successfully!` });
      });
};

// 전체 삭제
exports.deleteAll = (req,res)=>{
    Reservation.removeAll((err, data) => {
        if (err)
          res.status(500).send({
            message:
              err.message || "Some error occurred while removing all reservations."
          });
        else res.send({ message: `All Reservations were deleted successfully!` });
      });
};
 
 
