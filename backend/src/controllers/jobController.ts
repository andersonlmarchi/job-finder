import type { Request, Response } from "express"
import { JobService } from "../services/jobService"
import type { NewJob } from "../models/jobSchema"

export class JobController {
    private jobService: JobService

    constructor() {
        this.jobService = new JobService()
    }

    async searchJobs(req: Request, res: Response) {
        try {
            const { q } = req.query
            const jobs = await this.jobService.searchJobs(q as string)
            const jobsWithStringIds = jobs.map(job => ({
                ...job,
                id: job.id.toString()
            }))
            return res.json(jobsWithStringIds)
        } catch (error) {
            console.error("Error searching jobs:", error)
            return res.status(500).json({ error: "Internal server error" })
        }
    }

    async createJob(req: Request, res: Response) {
        try {
            const newJob: NewJob = req.body
            const job = await this.jobService.createJob({
                ...newJob,
                description: newJob.description ?? ""
            })
            return res.status(201).json(job)
        } catch (error) {
            console.error("Error creating job:", error)
            return res.status(500).json({ error: "Internal server error" })
        }
    }

    async getJobById(req: Request, res: Response) {
        try {
            const { id } = req.params
            const job = await this.jobService.getJobById(Number(id))
            if (job) {
                const jobWithStringId = {
                    ...job,
                    id: job.id.toString()
                }
                return res.json(jobWithStringId)
            } else {
                return res.status(404).json({ error: "Job not found" })
            }
        } catch (error) {
            console.error("Error getting job:", error)
            return res.status(500).json({ error: "Internal server error" })
        }
    }

    async updateJob(req: Request, res: Response) {
        try {
            const { id } = req.params
            const updatedJob = req.body
            const job = await this.jobService.updateJob(Number(id), updatedJob)
            if (job) {
                return res.json(job)
            } else {
                return res.status(404).json({ error: "Job not found" })
            }
        } catch (error) {
            console.error("Error updating job:", error)
            return res.status(500).json({ error: "Internal server error" })
        }
    }

    async deleteJob(req: Request, res: Response) {
        try {
            const { id } = req.params
            const success = await this.jobService.deleteJob(Number(id))
            if (success) {
                return res.status(204).send()
            } else {
                return res.status(404).json({ error: "Job not found" })
            }
        } catch (error) {
            console.error("Error deleting job:", error)
            return res.status(500).json({ error: "Internal server error" })
        }
    }
}
