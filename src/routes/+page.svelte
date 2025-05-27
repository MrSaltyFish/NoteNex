<!-- <script>
    import Header from '../lib/components/Header.svelte'
    import Footer from '../lib/components/Footer.svelte'
</script>

<Header />

<h1>
    Notenex - A note sharing Platform for my college friends
</h1>

<Footer /> -->

<script lang="ts">
	import { supabase } from '$lib/supabaseClient'

	let data

	const fetchData = async () => {
		const { data: files, error } = await supabase
			.from('pdfs')
			.select('*')

		if (error) console.error('Supabase error:', error)
		else data = files
	}

	fetchData()
</script>

{#if data}
	<h2 class="text-xl font-bold">PDFs</h2>
	<ul>
		{#each data as pdf}
			<li>{pdf.title}</li>
		{/each}
	</ul>
{:else}
	<p>Loading PDFs...</p>
{/if}
