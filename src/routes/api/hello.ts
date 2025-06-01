import type { RequestHandler } from '@sveltejs/kit';

export const GET: RequestHandler = () => {
	return new Response(JSON.stringify({ message: 'Hello from NoteNex API!' }), {
		headers: {
			'Content-Type': 'application/json'
		}
	});
};
