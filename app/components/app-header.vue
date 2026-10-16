<template>
  <header class="w-full border-b">
    <div class="mx-auto w-full max-w-7xl p-6 flex justify-between items-center">
      <NuxtLink to="/" class="font-extrabold text-2xl hover:text-green-600"
        >Finance tracker</NuxtLink
      >

      <UDropdownMenu
        v-if="user"
        :items="userMenu"
        class="cursor-pointer"
        :ui="{
          item: 'data-disabled:cursor-text data-disabled:select-all',
          content: 'w-64',
        }"
      >
        <UAvatar :src="avatarUrl" alt="Avatar" size="xl" class="bg-white" />
        <template #account="{ item }: { item: DropdownMenuItem }">
          <div class="flex space-x-2 cursor-text min-w-0">
            <UIcon
              name="i-heroicons-envelope"
              class="size-5 shrink-0 text-dimmed"
            />
            <div class="flex flex-col items-start">
              <span class="text-sm text-dimmed">Signed in as</span>

              <span class="text-gray-900 dark:text-white max-w-54 truncate">
                {{ user.email }}
              </span>
            </div>
          </div>
        </template>
      </UDropdownMenu>
    </div>
  </header>
</template>
<script setup lang="ts">
import type { DropdownMenuItem } from "@nuxt/ui";

const { user, logout, avatarUrl } = useAuth();

const toast = useToast();
const userLogout = async () => {
  console.log("UserLogout");
  await logout();
  navigateTo("/login");
  toast.add({
    title: "You was signed out",
    color: "success",
  });
};

const userMenu = computed<DropdownMenuItem[][]>(() => [
  [
    {
      slot: "account",
      disabled: true,
    },
  ],
  [
    {
      label: "Settings",
      icon: "i-lucide-cog",
      onSelect: () => navigateTo("/settings/profile"),
      //kbds: [","],
      class: "cursor-pointer",
    },
    {
      label: "Sign out",
      icon: "i-heroicons-arrow-right-on-rectangle",
      class: "cursor-pointer",
      onSelect: userLogout,
    },
  ],
]);
</script>
