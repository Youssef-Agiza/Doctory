const express = require("express")
const AppRouter = require("./routers")
const { errorHandler } = require("./controllers/error")
const path = require("path")
const cors = require("cors")
const AppError = require("./utils/AppError")

const app = express()

app.use(express.static(path.join(__dirname, "public")))
app.use(express.json())

const corsOptions = {
  origin: [process.env.DEV_BASE_URL, process.env.PROD_BASE_URL],
}

app.use(cors(corsOptions))
app.options("*", cors(corsOptions))

// Routes
app.use("/api", AppRouter)

// Catch undefined routes
app.all("*", (req, res, next) => {
  next(new AppError(`Can't find your requested route on server`, 404))
})

// Error handler
app.use(errorHandler)

module.exports = app
