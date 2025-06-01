// src/routes/examples/[exampleId]/+page.ts
export function load({ params }) {
	return {
		exampleId: params.exampleId
	};
}
