<template>
  <div class="px-4 flex min-h-screen flex-col mx-auto w-full">
    <AppHeader />
    <main class="container max-w-7xl py-10 flex-1 mx-auto px-6 w-full">
      <slot />
    </main>
    <AppFooter />
  </div>
</template>
<script setup lang="ts">
//Link to Gogle Fonts
useHead({
  link: [
    {
      rel: "preconnect",
      href: "https://fonts.googleapis.com",
    },
    {
      rel: "stylesheet",
      href: "https://fonts.googleapis.com/css2?family=Inter&display=swap",
      crossorigin: "",
    },
  ],
});
</script>
