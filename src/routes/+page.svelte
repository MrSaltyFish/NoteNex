<script>
  export let data;
  const { pdfs } = data;

  // Group PDFs by subject and chapter
  let grouped = {};
  for (const pdf of pdfs) {
    if (!grouped[pdf.subject]) grouped[pdf.subject] = {};
    if (!grouped[pdf.subject][pdf.chapter]) grouped[pdf.subject][pdf.chapter] = [];
    grouped[pdf.subject][pdf.chapter].push(pdf);
  }
</script>

<main class="max-w-4xl mx-auto p-6">
  <h1 class="text-4xl font-bold mb-8 text-center">📚 NoteNex PDF Library</h1>

  {#if pdfs.length === 0}
    <p class="text-center text-gray-500">No PDFs available yet.</p>
  {:else}
    {#each Object.entries(grouped) as [subject, chapters]}
      <section class="mb-10">
        <h2 class="text-2xl font-semibold mb-4 border-b border-red-500 pb-1">{subject}</h2>

        {#each Object.entries(chapters) as [chapter, chapterPdfs]}
          <article class="mb-6 pl-4">
            <h3 class="text-xl font-medium mb-2">{chapter}</h3>
            <ul class="list-disc ml-6 space-y-1">
              {#each chapterPdfs as pdf}
                <li>
                  <a
                    href={`https://YOUR_SUPABASE_STORAGE_URL/${pdf.id}.pdf`}
                    target="_blank"
                    class="text-blue-600 hover:underline"
                    rel="noopener noreferrer"
                  >
                    {pdf.title}
                  </a>
                  {#if pdf.description}
                    <span class="text-gray-600 text-sm ml-2">- {pdf.description}</span>
                  {/if}
                </li>
              {/each}
            </ul>
          </article>
        {/each}
      </section>
    {/each}
  {/if}
</main>

<style>
  main {
    font-family: system-ui, sans-serif;
  }
</style>
