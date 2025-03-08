import express from "express"

const app = express()

app.get("/health", (req, res) => {
  res.status(200).json({
    from: "BLUE",
    health: "HEALTHY",
    ip: req.ip
  })
})

app.listen(9090, () => {
  console.log("Running in Blue")
})
