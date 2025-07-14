import { openai } from "@ai-sdk/openai";
import { MDocument } from "@mastra/rag";
import {embedMany} from 'ai'
import { mastra } from "../"

// Load the paper
const paperUrl = "https://arxiv.org/html/1706.03762";
const response = await fetch(paperUrl);
const paperText = await response.text();

// Create a document and chunk it
const doc = MDocument.fromText(paperText);
const chunks = await doc.chunk({
    strategy: "recursive",
    size: 512,
    overlap: 50,
    separator : "\n"
});

console.log("Number of chunks:" + chunks.length);

const vectorStore = mastra.getVector('pgVector')