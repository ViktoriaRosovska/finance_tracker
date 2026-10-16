<template>
  <div>
    <h2 class="text-center mb-4">User Profile</h2>
    <UForm
      :schema="schemaUpdateUser"
      @submit="onSubmit"
      :state="state"
      class="flex flex-col space-y-2"
    >
      <UFormField label="Full Name" name="name">
        <UInput v-model="state.name" placeholder="Name" class="w-full" />
      </UFormField>
      <UFormField
        label="Email"
        name="email"
        help="If you change your email address, you will receive a confirmation email at both your current and new email addresses."
      >
        <UInput placeholder="Email" v-model="state.email" class="w-full" />
      </UFormField>
      <UFormField label="Password" name="password">
        <UInput
          type="password"
          v-model="state.password"
          placeholder="password"
          class="w-full"
        />
      </UFormField>
      <UButton
        label="Save"
        type="submit"
        class="m-auto mt-4"
        :loading="isLoading"
        loading-icon="i-heroicons-arrow-path"
        :disabled="isLoading"
      />
    </UForm>
  </div>
</template>
<script setup lang="ts">
import type { UpdateUser } from "~/types";
import { schemaUpdateUser } from "~/validation/schemaUpdateUser";
import type { AuthError } from "@supabase/supabase-js";

const { user, updateUser } = useAuth();

const initialState = reactive({
  name: user.value?.user_metadata?.name ?? "",
  email: user.value?.email ?? "",
});

const state = reactive({
  name: initialState.name,
  email: initialState.email,
  password: "",
});

watch(
  user,
  (newUser) => {
    if (!newUser) return;

    state.name = newUser.user_metadata?.name ?? "";
    state.email = newUser.email ?? "";
  },
  { immediate: true },
);
const isLoading = ref(false);

const onSubmit = async () => {
  const updates: UpdateUser = {};

  isLoading.value = true;
  try {
    if (state.email !== initialState.email) {
      updates.email = state.email;
    }
    if (state.name !== initialState.name) {
      updates.data = { name: state.name };
    }
    if (Object.keys(updates).length === 0) {
      toast.toastInfo({
        title: "Nothing to update",
        description: "No changes were made to your profile.",
      });
      return;
    }
    console.log("Update User:", updates);
    const data = await updateUser(updates);
    console.log("data", data);
    toast.toastSuccess({
      title: "Profile updated",
      description: "Your changes have been saved successfully.",
    });
  } catch (error) {
    const authError = error as AuthError;
    toast.toastError({
      title: "Error updating profile",
      description: authError.message,
    });
  } finally {
    isLoading.value = false;
  }
};
const toast = useAppToast();
</script>
