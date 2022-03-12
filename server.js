require("dotenv").config()

const app = require("./app")

process.on("uncaughtException", (err) => {
  console.log("UNCAUGHT EXCEPTION! 💥 Shutting down...")
  console.log(err.name, err.message)
  process.exit(1)
})

// TODO DB connection goes here

const port = process.env.PORT || 8000
const server = app.listen(port, () => {
  console.log(`Server is listening to ${process.env.PORT || 8000}...`)
})

process.on("unhandledRejection", (err) => {
  console.log("UNHANDLED REJECTION! 💥 Shutting down...")
  console.log(err.name, err.message)
  server.close(() => {
    process.exit(1)
  })
})

process.on("SIGTERM", () => {
  console.log("👋 SIGTERM RECEIVED. Shutting down gracefully")
  server.close(() => {
    console.log("💥 Process terminated!")
  })
})
