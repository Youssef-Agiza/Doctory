const jwt = require("jsonwebtoken")
const prisma = require("../models")
const AppError = require("../utils/AppError")
const { catchAsync } = require("./error")
const { isCorrectPassword } = require("../models/auth")

// check if the user is logged in through header token
// if token is verified, user data is added to req object
exports.protectRoute = catchAsync(async (req, res, next) => {
  try {
    let token = ""
    if (
      req.headers.authorization &&
      req.headers.authorization.startsWith("Bearer")
    ) {
      token = req.headers.authorization.split(" ")[1]
    }

    if (!token) throw Error("unauthorized")

    const decodedToken = jwt.verify(token, process.env.JWT_SECRET, {
      maxAge: process.env.JWT_EXPIRY,
    })

    // check if user still exists and get his data
    const user = await prisma.user.findUnique({
      where: { id: decodedToken.id },
    })

    if (!user) throw Error("notFound")

    // check if user changed password after issuing date
    // 30 seconds added to changed password date because it might be issued at the same time
    // when password is changed through /change-password
    if (
      user.passwordChangedAt &&
      new Date(user.passwordChangedAt).getTime() - 10000 >
        decodedToken.iat * 1000
    )
      throw Error("unauthorized")

    // add the user on the req object
    req.user = user

    next()
  } catch (err) {
    if (err === "notFound") return next(new AppError("User is not found"), 404)
    else return next(new AppError("unauthorized", 401))
  }
})

// create a token to be sent to user
const signToken = (id) =>
  jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRY,
  })

// default template of user data response
const returnUserData = (user) => ({
  id: user.id,
  name: user.name,
  mname: user.mname,
  lname: user.lname,
  phone: user.phone,
  email: user.email,
  address: user.address,
  birthdate: user.birthdate,
  role: user.role,
})

// create token credentials
const createSendTokenResponse = (user, statusCode, res, req) => {
  const token = signToken(user.id)

  return res.status(statusCode).json({
    status: "success",
    token,
    data: {
      user: returnUserData(user),
    },
  })
}

exports.signup = catchAsync(async (req, res, next) => {
  const { id, name, mname, lname, phone, password, role } = req.body
  const user = await prisma.user.create({
    data: { id, name, mname, lname, phone, password, role },
  })
  createSendTokenResponse(user, 201, res, req)
})

exports.login = catchAsync(async (req, res, next) => {
  const { id, password } = req.body

  // find user of the national id in the request
  const user = await prisma.user.findUnique({ where: { id } })

  // check if the password of the request national id is correct
  let correctPassword = false
  if (user) correctPassword = await isCorrectPassword(password, user.password)

  if (!user || !correctPassword)
    return next(new AppError("incorrect national id or password", 401))

  createSendTokenResponse(user, 200, res, req)
})

// export const changePassword = catchAsync(async (req, res, next) => {
//   const correctPassword = await isCorrectPassword(
//     req.body.oldPassword,
//     req.user?.password
//   );

//   if (!correctPassword)
//     return next(
//       new AppError("incorrect old password",
//         401
//       )
//     );

//   const user = await prisma.user.update({
//     where: {
//       id: req.user?.id,
//     },
//     data: {
//       password: req.body.password,
//     },
//   });

//   createSendTokenResponse(user, 200, res, req);
// });
