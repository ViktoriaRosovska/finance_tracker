<template>
  <UModal
    title="Sign-in to Finance Tracker"
    description="You will receive an email with the confirmation link"
    :close="{
      color: 'neutral',
      variant: 'ghost',
      class: 'rounded-full',
    }"
    @after:leave=""
    v-model:open="isOpen"
  >
    <UButton
      icon="i-heroicons-outline-login"
      color="neutral"
      variant="ghost"
      label="Sign In"
    />

    <template #body>
      <UForm
        ref="form"
        @submit="onSubmit"
        class="flex flex-col space-y-6"
        :state="state"
      >
        <UFormField label="User name" name="name">
          <UInput
            v-model="state.name"
            class="w-full"
            name="name"
            placeholder="Your Name"
          />
        </UFormField>
        <UFormField label="User Email" required name="email">
          <UInput
            v-model.number="state.email"
            placeholder="Your Email"
            name="email"
            type="email"
            class="w-full"
          />
        </UFormField>

        <UButton
          type="submit"
          class="w-30 flex justify-center m-auto"
          label="Sign-in"
          :loading="isLoading"
          loading-icon="i-heroicons-arrow-path"
        />
      </UForm>
    </template>
  </UModal>
</template>
<script setup lang="ts">
const isOpen = ref(false);
const isLoading = ref(false);
const onSubmit = () => console.log("Sign-in user");
const state = reactive({
  name: "",
  email: "",
});
</script>
