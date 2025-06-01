<script>
  // Put any global state or logic here if needed later
  import '../app.css'
</script>

<nav style="padding: 1rem; background: #222; color: white;">
  <a href="/" style="margin-right: 1rem; color: white;">Home</a>
  <a href="/about" style="margin-right: 1rem; color: white;">About</a>
  <a href="/docs" style="margin-right: 1rem; color: white;">Docs</a>
  <a href="/examples" style="color: white;">Examples</a>
</nav>

<main style="padding: 1rem;">
  <slot />
</main>
