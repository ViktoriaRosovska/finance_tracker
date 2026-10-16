<template>
  <UCard v-if="!success">
    <template #header> Sign-in to Finance Tracker </template>
    <UForm
      ref="form"
      @submit="handleLogin"
      class="flex flex-col space-y-6"
      :state="state"
    >
      <!-- <UFormField label="User name" name="name">
        <UInput
          v-model="state.name"
          class="w-full"
          name="name"
          placeholder="Your Name"
        />
      </UFormField> -->
      <UFormField
        label="User Email"
        required
        name="email"
        help="You will receive an email with the confirmation link"
      >
        <UInput
          v-model="state.email"
          placeholder="Email"
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
        :disabled="!state.email"
      />
    </UForm>
  </UCard>
  <UCard v-else>
    <template #header> Email has been sent </template>
    <div class="text-center">
      <p class="mb-4">
        We have sent an email to <strong>{{ state.email }}</strong> with a link
        to sign-in.
      </p>
      <p><strong>Important:</strong> The link expire in 5 minutes.</p>
    </div>
    <!-- <UForm :state="state" class="flex flex-col space-y-6">
      <UFormField label="User Name">
        <UInput placeholder="Name" />
      </UFormField>
      <UFormField label="User Email">
        <UInput placeholder="Email" :disabled="true" />
      </UFormField>
      <UButton
        type="submit"
        class="w-30 flex justify-center m-auto"
        label="Update"
        :loading="isLoading"
        loading-icon="i-heroicons-arrow-path"
        @click="success = true"
      />
    </UForm> -->
  </UCard>
</template>
<script setup lang="ts">
import type { AuthError } from "@supabase/supabase-js";
const isLoading = ref(false);
const state = reactive({
  //   name: "",
  email: "",
});
const success = ref(false);
const toast = useAppToast();
const { userSignIn } = useAuth();
const { redirectIfAuthenticate } = useAuth();

redirectIfAuthenticate("/");
const handleLogin = async () => {
  isLoading.value = true;

  try {
    await userSignIn(state.email);

    toast.toastSuccess({
      title: "Letter was send",
      description: "Attempt the link",
    });
    success.value = true;
  } catch (error) {
    const authError = error as AuthError;
    if (authError.status === 429) {
      toast.toastError({
        title: "Too many attempts",
        description: "Too many login attempts. Please try again later.",
      });
    } else {
      toast.toastError({
        title: "Error authenticating",
        description: authError.message,
      });
    }
  } finally {
    isLoading.value = false;
  }
};
</script>
