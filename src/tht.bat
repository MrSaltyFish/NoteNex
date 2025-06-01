@echo off
REM Check if routes folder exists
if not exist routes (
    mkdir routes
)
cd routes

REM Root files
type nul > +layout.svelte
type nul > +page.svelte
type nul > 404.svelte

REM About page
if not exist about mkdir about
type nul > about\+page.svelte

REM Docs section
if not exist docs mkdir docs
if not exist docs\[topic] mkdir docs\[topic]
type nul > docs\+layout.svelte
type nul > docs\+page.svelte
type nul > docs\[topic]\+page.svelte

REM Examples section
if not exist examples mkdir examples
if not exist examples\[exampleId] mkdir examples\[exampleId]
type nul > examples\+page.svelte
type nul > examples\[exampleId]\+page.svelte

REM API folder and example endpoint
if not exist api mkdir api
(
echo import type ^{ RequestHandler ^} from '^@sveltejs/kit'^;
echo.
echo export const GET: RequestHandler = () => ^{
echo   return new Response(JSON.stringify(^{ message: '^Hello from API!'^ }^), ^{
echo     headers: ^{ 'Content-Type': 'application/json' ^}
echo   ^});
echo ^};
) > api\hello.ts

echo Routing structure created successfully.
