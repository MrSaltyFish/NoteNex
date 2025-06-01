<script lang="ts">
  export let params: { topic: string };
  type DocTopics = "getting-started" | "api-reference" | "advanced-usage";

  const docs: Record<DocTopics, string> = {
    "getting-started": "Learn how to set up and start using NoteNex in minutes.",
    "api-reference": "Comprehensive API documentation for NoteNex.",
    "advanced-usage": "Deep dive into advanced features and customization."
  };

  const topic = params.topic as DocTopics;

  let content = docs[topic] ?? "Documentation not found.";
</script>
