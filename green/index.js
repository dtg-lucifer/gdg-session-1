import express from "express"

const app = express()

app.get("/health", (req, res) => {
  res.status(200).json({
    from: "GREEN",
    health: "HEALTHY",
    ip: req.ip
  })
})

app.listen(8080, () => {
  console.log("Running in Green")
})
