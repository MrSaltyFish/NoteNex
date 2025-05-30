// src/routes/+page.server.ts
import { supabase } from '$lib/supabaseClient';

export async function load() {
	const { data, error } = await supabase
		.from('pdfs')
		.select('id, title, subject, chapter, description')
		.order('subject', { ascending: true })
		.order('chapter', { ascending: true });

	if (error) {
		console.error('Error fetching PDFs:', error);
		return { pdfs: [] };
	}

	return {
		pdfs: data
	};
}
