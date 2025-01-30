import { Router } from "express"
import { JobController } from "../controllers/jobController"

const router = Router()
const jobController = new JobController()

router.get("/search", (req, res) => jobController.searchJobs(req, res))
router.post("/", (req, res) => jobController.createJob(req, res))
router.get("/:id", (req, res) => jobController.getJobById(req, res))
router.put("/:id", (req, res) => jobController.updateJob(req, res))
router.delete("/:id", (req, res) => jobController.deleteJob(req, res))

export default router
