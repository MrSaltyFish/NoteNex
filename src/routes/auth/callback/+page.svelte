<script lang="ts">
	import { onMount } from 'svelte';
	import { supabase } from '$lib/supabaseClient';
	import { goto } from '$app/navigation';

	onMount(async () => {
		const { data, error } = await supabase.auth.getSessionFromUrl();

		if (error) {
			console.error('Auth error:', error.message);
			alert('Login failed: ' + error.message);
			goto('/'); // redirect to home or an error page
		} else {
			console.log('Session:', data);
			goto('/dashboard');
		}
	});
</script>

<p>Logging you in…</p>
