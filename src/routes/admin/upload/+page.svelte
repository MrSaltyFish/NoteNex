<script lang="ts">
  import { supabase } from '$lib/supabaseClient';
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { writable } from 'svelte/store';

  const title = writable('');
  const subject = writable('');
  const chapter = writable('');
  const description = writable('');
  const file = writable<File | null>(null);
  const error = writable('');
  const loading = writable(false);

  let userId: string | null = null;

  // Replace with your Supabase auth user ID for admin
  const ADMIN_USER_ID = '354225c9-de53-4f50-bf26-056d998d04e7';

  onMount(async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user || user.id !== ADMIN_USER_ID) {
      goto('/not-authorized'); // redirect non-admins
    } else {
      userId = user.id;
    }
  });

  async function uploadPDF() {
    error.set('');
    loading.set(true);

    const $title = get(title);
    const $subject = get(subject);
    const $chapter = get(chapter);
    const $description = get(description);
    const $file = get(file);

    if (!$title || !$subject || !$chapter || !$file) {
      error.set('Please fill all required fields and select a PDF file.');
      loading.set(false);
      return;
    }

    if ($file.type !== 'application/pdf') {
      error.set('Only PDF files are allowed.');
      loading.set(false);
      return;
    }

    // Upload file to Supabase Storage
    const filePath = `pdfs/${Date.now()}_${$file.name}`;
    const { error: storageError } = await supabase.storage
      .from('pdf-files')
      .upload(filePath, $file);

    if (storageError) {
      error.set(`Upload failed: ${storageError.message}`);
      loading.set(false);
      return;
    }

    // Insert metadata in DB
    const { error: dbError } = await supabase.from('pdfs').insert({
      title: $title,
      subject: $subject,
      chapter: $chapter,
      description: $description,
      filepath: filePath,
      uploaded_by: userId,
      uploaded_at: new Date().toISOString()
    });

    if (dbError) {
      error.set(`Database insert failed: ${dbError.message}`);
      loading.set(false);
      return;
    }

    loading.set(false);
    alert('PDF uploaded successfully!');
    goto('/'); // redirect to homepage or wherever you want
  }

  // helper to get value from store
  import { get } from 'svelte/store';
</script>

<div class="max-w-xl mx-auto p-6 border rounded shadow mt-10">
  <h1 class="text-2xl font-bold mb-4 text-red-600">Admin PDF Upload</h1>

  {#if $error}
    <div class="bg-red-100 text-red-700 p-2 mb-4 rounded">{$error}</div>
  {/if}

  <form on:submit|preventDefault={uploadPDF} class="space-y-4">
    <div>
      <label class="block font-semibold mb-1">Title*</label>
      <input type="text" bind:value={$title} class="input" required />
    </div>

    <div>
      <label class="block font-semibold mb-1">Subject*</label>
      <input type="text" bind:value={$subject} class="input" required />
    </div>

    <div>
      <label class="block font-semibold mb-1">Chapter*</label>
      <input type="text" bind:value={$chapter} class="input" required />
    </div>

    <div>
      <label class="block font-semibold mb-1">Description</label>
      <textarea bind:value={$description} rows="3" class="input"></textarea>
    </div>

    <div>
      <label class="block font-semibold mb-1">Select PDF*</label>
      <input type="file" accept="application/pdf" on:change={(e) => file.set(e.target.files[0])} required />
    </div>

    <button type="submit" disabled={$loading} class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 disabled:opacity-50">
      {$loading ? 'Uploading...' : 'Upload PDF'}
    </button>
  </form>
</div>

<style>
  .input {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ccc;
    border-radius: 0.375rem;
  }
</style>
