export default function Home() {
  return (
    <main className="flex flex-1 items-center justify-center bg-zinc-50 px-6 py-24 font-sans">
      <section className="w-full max-w-xl rounded-2xl border border-zinc-200 bg-white p-10 shadow-sm">
        <p className="text-sm font-semibold uppercase tracking-widest text-sky-600">
          Módulo 5 · DevOps
        </p>
        <h1 className="mt-3 text-3xl font-bold text-zinc-900">
          Next.js dentro de un contenedor Docker 🐳
        </h1>
        <p className="mt-4 text-zinc-600">
          Esta aplicación se construyó con un <code className="font-mono">Dockerfile</code>{" "}
          multi-stage y se ejecuta con <code className="font-mono">next start</code> en el
          puerto <strong>3000</strong>.
        </p>
        <ul className="mt-6 space-y-2 text-sm text-zinc-700">
          <li>✅ Imagen base oficial <code className="font-mono">node:20-alpine</code></li>
          <li>✅ Build en varias etapas (deps → build → producción)</li>
          <li>✅ <code className="font-mono">.dockerignore</code> para una imagen ligera y segura</li>
          <li>✅ Usuario sin privilegios dentro del contenedor</li>
        </ul>
      </section>
    </main>
  );
}
