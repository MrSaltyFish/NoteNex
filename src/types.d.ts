export interface Pdf {
	id: string;
	subject: string;
	chapter: number;
	title: string;
	url: string; // Public URL to the PDF stored in Supabase Storage
}
