import { db } from "../configs/database"
import { jobs, type Job } from "../models/jobSchema"
import { eq, or, ilike } from "drizzle-orm"

export class JobService {
    async searchJobs(query: string): Promise<Job[]> {
        if (!query) {
            return db.select().from(jobs)
        }

        return db
            .select()
            .from(jobs)
            .where(
                or(
                    ilike(jobs.title, `%${query}%`),
                    ilike(jobs.company, `%${query}%`),
                    ilike(jobs.location, `%${query}%`),
                    ilike(jobs.description, `%${query}%`),
                ),
            )
    }

    async createJob(newJob: { title: string; company: string; location: string; description: string }): Promise<Job> {
        const [createdJob] = await db.insert(jobs).values(newJob).returning()
        return createdJob
    }

    async getJobById(id: number): Promise<Job | null> {
        const [job] = await db.select().from(jobs).where(eq(jobs.id, id))
        return job || null
    }

    async updateJob(id: number, updatedJob: Partial<Omit<Job, "id" | "createdAt" | "updatedAt">>): Promise<Job | null> {
        const [job] = await db
            .update(jobs)
            .set({ ...updatedJob, updatedAt: new Date() })
            .where(eq(jobs.id, id))
            .returning()
        return job || null
    }

    async deleteJob(id: number): Promise<boolean> {
        const result = await db.delete(jobs).where(eq(jobs.id, id))
        return (result.rowCount ?? 0) > 0
    }
    
}
