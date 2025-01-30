import { pgTable, serial, varchar, text, timestamp } from "drizzle-orm/pg-core"

export const jobs = pgTable("jobs", {
    id: serial("id").primaryKey(),
    title: varchar("title", { length: 255 }).notNull(),
    company: varchar("company", { length: 255 }).notNull(),
    location: varchar("location", { length: 255 }).notNull(),
    description: text("description"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at").defaultNow().notNull(),
})

import { InferModel } from "drizzle-orm"

export type Job = InferModel<typeof jobs>
export type NewJob = InferModel<typeof jobs, 'insert'>
