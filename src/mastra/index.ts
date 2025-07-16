import { Mastra } from '@mastra/core/mastra';
import { PgVector } from '@mastra/pg';
import { researchAgent } from './agents/researchAgent';

const pgVector = new PgVector({
  connectionString: process.env.POSTGRES_CONNECTION_STRING!,
});

export const mastra = new Mastra({
  agents: { researchAgent },
  vectors: { pgVector },
});
