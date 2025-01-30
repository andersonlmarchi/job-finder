import express, { type Request, type Response, type NextFunction } from "express"
import dotenv from "dotenv"
import cors from "cors"
import jobRoutes from "./routes/jobRoutes"

dotenv.config()

const app = express()
const port = process.env.PORT || 3000

// Adiciona middleware CORS
app.use(cors())

app.use(express.json())

// Rotas
app.use("/api/jobs", jobRoutes)

// Middleware de tratamento de erros
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error(err.stack)
    res.status(500).send("Something broke!")
})

app.listen(port, () => {
    console.log(`Server is running on port ${port}`)
})
