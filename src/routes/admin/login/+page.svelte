<script lang="ts">
	import { goto } from '$app/navigation';
	import { supabase } from '$lib/supabaseClient';

	let email = '';
	let password = '';
	let error = '';

	const ADMIN_UUID = 'your-admin-uuid-here'; // replace this with your Supabase UUID

	const handleLogin = async () => {
		error = '';

		const { data, error: loginError } = await supabase.auth.signInWithPassword({
			email,
			password
		});

		if (loginError) {
			error = loginError.message;
			return;
		}

		const user = data.user;

		if (user?.id === ADMIN_UUID) {
			goto('/admin/dashboard');
		} else {
			goto('/not-authorized');
		}
	};
</script>

<div class="flex flex-col items-center justify-center min-h-screen p-4">
	<h1 class="text-2xl font-bold mb-4">Admin Login</h1>
	<form
		class="flex flex-col gap-4 w-full max-w-sm"
		on:submit|preventDefault={handleLogin}
	>
		<input
			type="email"
			placeholder="Email"
			bind:value={email}
			class="p-2 border rounded"
			required
		/>
		<input
			type="password"
			placeholder="Password"
			bind:value={password}
			class="p-2 border rounded"
			required
		/>
		<button type="submit" class="bg-blue-600 text-white p-2 rounded hover:bg-blue-700">
			Login
		</button>
		{#if error}
			<p class="text-red-500">{error}</p>
		{/if}
	</form>
</div>
