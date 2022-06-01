module.exports = app =>{
    const reservations = require("../controllers/reservation.controller.js");

    // 튜플 생성
    /*
    create 는 DB를 생성하는 함수
    TOSQS 는 SQS에 메세지를 보내는 Producer 함수. 
    MERGE_DB_SQS 는 create 와 TOSQS 기능을 합친 함수. ( 지금 안됨 )
    */
    app.post("/reservations", reservations.create);

    // 전체 조회 
    app.get("/reservations", reservations.findAll);

    // id로 조회
    app.get("/reservations/:reservationId", reservations.findOne);
};