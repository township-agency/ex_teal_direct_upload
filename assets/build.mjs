import ESBuild from "esbuild";
import vuePlugin from "esbuild-vue";
import chokidar from "chokidar";

const production = process.argv.includes("--deploy");
const env = production ? "production" : "development";

const ctx = await ESBuild.context({
  entryPoints: [
    "./src/main.js"
  ],
  external: [
    'vue'
  ],
  bundle: true,
  outdir: "../priv/static/",
  plugins: [vuePlugin()],
  define: {
    "process.env.NODE_ENV": JSON.stringify(env),
  },
  minify: production
})

if (process.argv.includes("--watch")) {
  (async () => {
    chokidar.watch('src').on('all', async (_, p) => {
      console.log(`Changes were detected in: ${p}`);
      console.log('Rebuilding...');
      await ctx.rebuild();
    });
  })();
} else {
  await ctx.rebuild().then(() => {
    ctx.dispose();
  });
}
