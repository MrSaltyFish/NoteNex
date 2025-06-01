<script lang="ts">
  export let data: { exampleId: string };

  const exampleId = data.exampleId;

  type ExampleKey = "example-1" | "example-2" | "example-3";

  const examples: Record<ExampleKey, string> = {
    "example-1": "This is example 1.",
    "example-2": "This is example 2.",
    "example-3": "This is example 3."
  };

  function isExampleKey(key: string): key is ExampleKey {
    return key in examples;
  }

  const content = isExampleKey(exampleId)
    ? examples[exampleId]
    : "Example not found.";
</script>

<h1>{exampleId.replace(/-/g, " ").toUpperCase()}</h1>
<p>{content}</p>
