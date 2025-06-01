<script lang="ts">
  // Mock example list
  const examples = [
    { id: "example-1", title: "Basic Usage Example" },
    { id: "example-2", title: "Advanced Features Example" },
    { id: "example-3", title: "Integration Example" }
  ];
</script>

<h1>Examples</h1>
<ul>
  {#each examples as example}
    <li>
      <a href={`/examples/${example.id}`}>{example.title}</a>
    </li>
  {/each}
</ul>
