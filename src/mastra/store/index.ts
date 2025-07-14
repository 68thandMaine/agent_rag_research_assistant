import { openai } from '@ai-sdk/openai';
import { MDocument } from '@mastra/rag';
import { embedMany } from 'ai';
import { mastra } from '../';

const vectorStore = mastra.getVector('pgVector');

// Load the paper
const paperUrl = 'https://arxiv.org/html/1706.03762';
const response = await fetch(paperUrl);
const paperText = await response.text();

// Create a document and chunk it
const doc = MDocument.fromText(paperText);
const chunks = await doc.chunk({
  strategy: 'recursive',
  size: 512,
  overlap: 50,
  separator: '\n',
});

console.log('Number of chunks:' + chunks.length);

const { embeddings } = await embedMany({
  model: openai.embedding('text-embedding-3-small'),
  values: chunks.map((chunk) => chunk.text),
});

await vectorStore.createIndex({
  indexName: 'papers',
  dimension: 1536,
});

await vectorStore.upsert({
  indexName: 'papers',
  vectors: embeddings,
  metadata: chunks.map((chunk) => ({
    text: chunk.text,
    source: 'transformer-paper',
  })),
});
