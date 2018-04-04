const express = require("express")
const app = express()
const bodyParser = require("body-parser")

app.use(bodyParser.json())


let data = [
  {high: 55, low: 40, condition: "cloudy", day: "wednesday"},
  {high: 55, low: 40, condition: "cloudy", day: "Thrusday"},
  {high: 55, low: 40, condition: "cloudy", day: "friday"},
  {high: 55, low: 40, condition: "cloudy", day: "saterday"},
  {high: 55, low: 40, condition: "cloudy", day: "monday"},
  {high: 55, low: 40, condition: "cloudy", day: "tuesday"},
  {high: 55, low: 40, condition: "cloudy", day: "wednesday"},
  {high: 55, low: 40, condition: "cloudy", day: "thursday"},
  {high: 55, low: 40, condition: "cloudy", day: "friday"},
  {high: 55, low: 40, condition: "cloudy", day: "saterday"},
]


app.get("/data" , (req, res) => {
  console.log(" request ")
  res.json(data)
})


app.listen(3000, () => {
  console.log("server is listening on port 3000")
})