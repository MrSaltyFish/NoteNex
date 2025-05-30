<script lang="ts">
  import { supabase } from '$lib/supabaseClient';
  let title = '';
  let subject = '';
  let chapter = '';
  let file: File;

  async function handleUpload() {
    if (!file) return alert('Please select a file');

    const fileExt = file.name.split('.').pop();
    const filePath = `pdfs/${Date.now()}.${fileExt}`;

    const { data: uploadData, error: uploadError } = await supabase.storage
      .from('pdfs')
      .upload(filePath, file);

    if (uploadError) {
      alert(`Upload error: ${uploadError.message}`);
      return;
    }

    const { error: dbError } = await supabase.from('pdfs').insert({
      title,
      subject,
      chapter,
      file_url: uploadData?.path,
      uploaded_by: (await supabase.auth.getUser()).data.user?.id
    });

    if (dbError) {
      alert(`DB error: ${dbError.message}`);
    } else {
      alert('PDF uploaded!');
    }
  }
</script>

<form on:submit|preventDefault={handleUpload} class="space-y-4 p-4 max-w-lg mx-auto">
  <input type="text" bind:value={title} placeholder="Title" class="input" required />
  <input type="text" bind:value={subject} placeholder="Subject" class="input" />
  <input type="text" bind:value={chapter} placeholder="Chapter" class="input" />
  <input type="file" on:change={(e) => file = e.target.files[0]} accept="application/pdf" required />
  <button type="submit" class="btn bg-blue-600 text-white">Upload PDF</button>
</form>

<style>
  .input {
    width: 100%;
    padding: 0.5rem;
    border: 1px solid #ccc;
    border-radius: 0.375rem;
  }
</style>
