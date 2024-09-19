// app.get('/caraccident', async (req, res) => {
//     let sql = "SELECT * FROM caraccident"

//     await conn.execute(sql,
//         (err, result) => {
//             if (err) {
//                 res.status(500).json({
//                     message : err.message
//                 })
//                 return
//             }
//             res.status(200).json({
//                 message : "เรียกข้อมูลสำเร็จ",
//                 data : result
//             })    
//         }
//     )
// })

// app.post('/caraccident', async (req, res) => {
//     try {
//         const id = parseInt(req.body.id);
//         const localacc = req.body.localacc;
//         const latitude = parseFloat(req.body.latitude);
//         const longitude = parseFloat(req.body.longitude);
//         const injured = parseInt(req.body.injured);
//         const death = parseInt(req.body.death);
//         const accdate = new Date(req.body.accdate);

//         let sql = "INSERT INTO caraccident (id, localacc, latitude, longitude, injured, death, accdate) VALUES (?,?,?,?,?,?,?)";
//         conn.execute(sql, [id, localacc, latitude, longitude, injured, death, accdate], (err, result) => {
//             if (err) {
//                 return res.status(500).json({
//                     message: err.message
//                 });
//             }
//             res.status(201).json({
//                 message: "เพิ่มข้อมูลสำเร็จ",
//                 data: result
//             });
//         });
//     } catch (error) {
//         res.status(500).json({
//             message: error.message
//         });
//     }
// })

// app.get('/caraccident/:id', async(req, res) => {
//     const { id } = req.params
//     let sql = "SELECT * FROM caraccident WHERE id = ?"
//     conn.execute(sql,
//         [id],
//         (err, result) => {
//             if (err) {
//                 res.status(500).json({
//                     message : err.message
//                 })
//                 return
//             }
//             res.status(200).json({
//                 message : "เรียกข้อมูลสำเร็จ",
//                 data : result
//             })
//         }
//     )
// })

// app.put('/caraccident/:id', async (req, res) => {
//     try {
//         const { id } = req.params;
//         const { localacc, latitude, longitude, injured, death, accdate } = req.body;

//         const parsedLatitude = parseFloat(latitude);
//         const parsedLongitude = parseFloat(longitude);
//         const parsedInjured = parseInt(injured);
//         const parsedDeath = parseInt(death);
//         const parsedAccdate = new Date(accdate);

//         let sql = "UPDATE caraccident SET localacc = ?, latitude = ?, longitude = ?, injured = ?, death = ?, accdate = ? WHERE id = ?";

//         conn.execute(sql, [localacc, parsedLatitude, parsedLongitude, parsedInjured, parsedDeath, parsedAccdate, id], (err, result) => {
//             if (err) {
//                 return res.status(500).json({
//                     message: err.message
//                 });
//             }
//             res.status(201).json({
//                 message: "อัพเดทข้อมูลสำเร็จ",
//                 data: result
//             });
//         });
//     } catch (error) {
//         res.status(500).json({
//             message: error.message
//         });
//     }
// });

// app.delete('/caraccident/:id', async(req,res) => {
//     const { id } = req.params
//     let sql = "DELETE FROM caraccident WHERE id = ?"

//     conn.execute(sql,
//         [id],
//         (err, result) => {
//             if (err) {
//                 res.status(500).json({
//                     message : err.message
//                 })
//                 return
//             }
//             res.status(200).json({
//                 message : "ลบข้อมูลสำเร็จ",
//                 data : result
//             })
//         }
//     )
// })